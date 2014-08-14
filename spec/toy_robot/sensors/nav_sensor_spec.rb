require 'toy_robot/sensors/nav_sensor'

describe ToyRobot::Sensors::NavSensor do
  subject(:sensor) { described_class.new }
  let(:robot) { instance_double('ToyRobot::Robot', brain: {}) }
  let(:five_by_five_boundaries) { {boundary_x: 5, boundary_y: 5} }

  describe '#can?(:move)' do
    ToyRobot::Utils::Compass.cordinal_directions.each do |direction|
      it 'allows to go to any direction when not near border' do
        robot.brain[:target_location] = ToyRobot::Utils::Location.new(x: 1, y: 1, direction: direction)
        robot.brain[:initial] = five_by_five_boundaries.merge(place_x: 1, place_y: 1, direction: "NORTH")
        sensor.attach(robot)
        expect(sensor.can?(:move)).to eq(true)
      end
    end

    context 'when near a border' do
      before do
        robot.brain[:initial] = five_by_five_boundaries.merge(place_x: 0, place_y: 0, direction: "NORTH")
        sensor.attach(robot)
      end

      it 'does not allow to go to direction of a border if near boder' do
        robot.brain[:target_location] = ToyRobot::Utils::Location.new(x: 0, y: -1,
                                                                      direction: ToyRobot::Utils::Compass.south)
        expect(sensor.can?(:move)).to eq(false)

        robot.brain[:target_location] = ToyRobot::Utils::Location.new(x: -1, y: 0,
                                                                      direction: ToyRobot::Utils::Compass.west)
        expect(sensor.can?(:move)).to eq(false)
      end

      it 'does allow to go to direction opposite to a border' do
        robot.brain[:target_location] = ToyRobot::Utils::Location.new(x: 0, y: 1,
                                                                      direction: ToyRobot::Utils::Compass.north)
        expect(sensor.can?(:move)).to eq(true)

        robot.brain[:target_location] = ToyRobot::Utils::Location.new(x: 0, y: 1,
                                                                      direction: ToyRobot::Utils::Compass.north)
        expect(sensor.can?(:move)).to eq(true)
      end
    end
  end

  describe '#data' do
    it 'should return distance from south and west as x and y coordinates' do
      robot = instance_double('ToyRobot::Robot', brain: {
        initial: five_by_five_boundaries.merge(place_x: 2, place_y: 3, direction: "NORTH")
      })
      sensor.attach(robot)
      data = sensor.data
      expect(data[:x]).to eq(2)
      expect(data[:y]).to eq(3)
    end
  end

  describe '#attach' do
    it 'creates new current location' do
      robot = instance_double('ToyRobot::Robot', brain: {
        initial: five_by_five_boundaries.merge(place_x: 0, place_y: 0, direction: "NORTH")
      })
      sensor.attach(robot)

      current_location = robot.brain[:current_location]
      expect(current_location).to eql(ToyRobot::Utils::Location.new(x: 0, y: 0, direction: ToyRobot::Utils::Compass.north))
    end
  end
end
