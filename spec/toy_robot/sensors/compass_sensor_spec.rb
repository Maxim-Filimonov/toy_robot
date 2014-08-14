require 'toy_robot/sensors/compass_sensor'

describe ToyRobot::Sensors::CompassSensor do

  describe '#data' do
    it 'returns current direction in upper case format' do
      robot = instance_double('ToyRobot::Robot', brain: {
        current_location: ToyRobot::Utils::Location.new(x: 0, y: 0, direction: ToyRobot::Utils::Compass.north)}
      )
      subject.attach(robot)

      expect(subject.data[:direction]).to eq("NORTH")
    end
  end

  describe '#can?' do
    it 'allows any move' do
      expect(subject.can?(:move)).to eq(true)
    end
  end
end
