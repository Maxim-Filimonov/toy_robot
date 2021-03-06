require 'toy_robot/robot'

describe ToyRobot::Robot do
  describe '.place' do
    describe 'pre-flight checks' do
      it 'does not allow to land outside of X coordinates' do
        robot = described_class.place(place_x: 6, place_y: 0, direction: "NORTH")
        expect(robot).to be_nil
      end

      it 'does not allow to land outside of Y coordinates' do
        robot = described_class.place(place_x: 0, place_y: 6, direction: "NORTH")
        expect(robot).to be_nil
      end

      it 'can land on the far edge' do
        robot = described_class.place(place_x: 5, place_y: 5, direction: "NORTH")
        expect(robot).to_not be_nil
      end
    end

    it 'initialises all sensors on landing' do
      sensor = instance_double('ToyRobot::Sensors::NavSensor')

      expect(sensor).to receive(:attach).with(instance_of(described_class))

      described_class.place(place_x: 1, place_y: 2, direction: "SOUTH", sensors: [sensor])
    end

    it 'fills brain with initial data' do
      args = {place_x: 1, place_y: 2, direction: "SOUTH"}

      robot = described_class.place(args)
      expected = args.merge(boundary_x: ToyRobot::Robot::DEFAULT_MAX_X,
                            boundary_y: ToyRobot::Robot::DEFAULT_MAX_Y)
      expect(robot.brain[:initial]).to eq(expected)
    end

    it 'allows to override max coordinates' do
      args = {place_x: 1, place_y: 2, direction: "SOUTH", boundary_x: 10, boundary_y: 12}

      robot = described_class.place(args)
      expect(robot.brain[:initial]).to eq(args)
    end

  end

  context 'after robot is placed' do
    let(:sensor) { instance_double('ToyRobot::Sensors::NavSensor', attach: true) }
    let(:movement_system) { instance_double('ToyRobot::Systems::ChassisSystem', attach: true) }
    subject(:placed_robot) { described_class.new(sensors: [sensor],
                                                 movement_system: movement_system) }
    describe '#move_forward' do
      context 'when all sensors allow movement' do
        it 'moves the chassis' do
          expect(movement_system).to receive(:request_move_forward)
          allow(sensor).to receive(:can?).with(:move).and_return(true)

          expect(movement_system).to receive(:move)

          placed_robot.move_forward
        end
      end

      context 'when one of sensors does not allow movement' do
        it 'stays on the same place' do
          allow(movement_system).to receive(:request_move_forward)
          allow(sensor).to receive(:can?).with(:move).and_return(false)

          expect(movement_system).to_not receive(:move)
          placed_robot.move_forward
        end
      end
    end

    describe '#rotate_anticlockwise' do
      context 'when all sensors allow movement' do
        it 'moves the chassis' do
          expect(movement_system).to receive(:request_rotate_anticlockwise)
          allow(sensor).to receive(:can?).with(:move).and_return(true)

          expect(movement_system).to receive(:move)

          placed_robot.rotate_anticlockwise
        end
      end

      context 'when one of sensors does not allow movement' do
        it 'stays on the same place' do
          allow(movement_system).to receive(:request_move_forward)
          allow(sensor).to receive(:can?).with(:move).and_return(false)

          expect(movement_system).to_not receive(:move)
          placed_robot.move_forward
        end
      end
    end

    describe '#rotate_clockwise' do
      context 'when all sensors allow movement' do
        it 'moves the chassis' do
          expect(movement_system).to receive(:request_rotate_clockwise)
          allow(sensor).to receive(:can?).with(:move).and_return(true)

          expect(movement_system).to receive(:move)

          placed_robot.rotate_clockwise
        end
      end

      context 'when one of sensors does not allow movement' do
        it 'stays on the same place' do
          allow(movement_system).to receive(:request_rotate_clockwise)
          allow(sensor).to receive(:can?).with(:move).and_return(false)

          expect(movement_system).to_not receive(:move)
          placed_robot.rotate_clockwise
        end
      end
    end

    describe '#report' do
      it 'puts data for sensor with name' do
        allow(sensor).to receive(:name).and_return(:bogus_sensor)
        allow(sensor).to receive(:data).and_return({foo: :bar})

        report = placed_robot.report
        expect(report[:bogus_sensor]).to eq(foo: :bar)
      end
    end
  end
end
