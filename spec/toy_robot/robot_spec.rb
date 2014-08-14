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
  end

  describe '#move_forward' do
    let(:sensor)  { instance_double('ToyRobot::Sensors::NavSensor', attach: true) }
    let(:movement_system)  { instance_double('ToyRobot::Systems::ChassisSystem', attach: true) }
    subject(:placed_robot) { described_class.new(sensors: [sensor],
      movement_system: movement_system) }

    context 'when all sensors allow movement' do
      it 'moves the chassis' do
        allow(sensor).to receive(:can?).with(:move).and_return(true)

        expect(movement_system).to receive(:move_forward)

        placed_robot.move_forward
      end
    end
    context 'when one of sensors does not allow movement' do
      it 'stays on the same place' do
        allow(sensor).to receive(:can?).with(:move).and_return(false)

        expect(movement_system).to_not receive(:move_forward)
        placed_robot.move_forward
      end
    end
  end
end
