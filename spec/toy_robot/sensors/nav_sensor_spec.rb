require 'toy_robot/sensors/nav_sensor'

describe ToyRobot::Sensors::NavSensor do
  subject(:sensor) { described_class.new }

  let(:five_by_five_boundaries) { {boundary_x: 5, boundary_y: 5} }
  describe '#detect_borders' do
    [[0, 4], [4, 0], [2, 2], [3, 1]].each do |test_data|
      it 'detects north distance' do
        sensor.detect_borders five_by_five_boundaries.merge(placement_x: 0, placement_y: test_data[0])
        expect(sensor.steps_left_to_north_border).to eq(test_data[1])
      end

      it 'detects east distance' do
        sensor.detect_borders five_by_five_boundaries.merge(placement_x: test_data[0], placement_y: 0)
        expect(sensor.steps_left_to_east_border).to eq(test_data[1])
      end
    end

    [[0, 0], [4, 4], [2, 2], [3, 3]].each do |test_data|
      it 'detects south distance' do
        sensor.detect_borders five_by_five_boundaries.merge(placement_x: 0, placement_y: test_data[0])
        expect(sensor.steps_left_to_south_border).to eq(test_data[1])
      end

      it 'detects west distance' do
        sensor.detect_borders five_by_five_boundaries.merge(placement_x: test_data[0], placement_y: 0)
        expect(sensor.steps_left_to_west_border).to eq(test_data[1])
      end
    end
  end

  describe '#can?(:move)' do
    let(:robot) { instance_double('ToyRobot::Robot', brain: {}) }
    before do
      sensor.attach(robot)
    end

    ToyRobot::Utils::Compass.cordinal_directions.each do |direction|
      it 'allows to go to any direction when not near border' do
        robot.brain[:current_direction] = direction
        sensor.detect_borders five_by_five_boundaries.merge(placement_x: 1, placement_y: 1)
        expect(sensor.can?(:move)).to eq(true)
      end
    end

    context 'when near a border' do
      before do
        sensor.detect_borders five_by_five_boundaries.merge(placement_x: 0, placement_y: 0)
      end

      it 'does not allow to go to direction of a border if near boder' do
        robot.brain[:current_direction] = ToyRobot::Utils::Compass.south
        expect(sensor.can?(:move)).to eq(false)

        robot.brain[:current_direction] = ToyRobot::Utils::Compass.west
        expect(sensor.can?(:move)).to eq(false)
      end

      it 'does allow to go to direction opposite to a border' do
        robot.brain[:current_direction] = ToyRobot::Utils::Compass.north
        expect(sensor.can?(:move)).to eq(true)

        robot.brain[:current_direction] = ToyRobot::Utils::Compass.east
        expect(sensor.can?(:move)).to eq(true)
      end
    end
  end

  describe '#update' do
    before do
      sensor.detect_borders five_by_five_boundaries.merge(placement_x: 0, placement_y: 0)
    end

    it 'updates sensor for direction which robot has moved' do
      sensor.update(ToyRobot::Utils::Compass.north)
      expect(sensor.steps_left_to_north_border).to eq(3)
    end

    it 'updates sensor for opposite direction of the robot movement' do
      sensor.update(ToyRobot::Utils::Compass.north)
      expect(sensor.steps_left_to_south_border).to eq(1)
    end
  end

  describe '#coordinates_from_south_west' do

    it 'should return distance from south and west as x and y coordinates' do
      sensor.detect_borders five_by_five_boundaries.merge(placement_x: 2, placement_y: 3)
      x, y = sensor.coordinates_from_south_west
      expect(x).to eq(2)
      expect(y).to eq(3)
    end
  end
end
