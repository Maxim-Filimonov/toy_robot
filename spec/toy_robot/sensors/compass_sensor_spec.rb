require 'toy_robot/sensors/compass_sensor'

describe ToyRobot::Sensors::CompassSensor do
  describe '#attach' do
    it 'sets current direction' do
      robot = instance_double('ToyRobot::Robot', brain: {
        initial: { direction: "NORTH"}
        })

      subject.attach(robot)

      expect(robot.brain[:current_direction]).to eq(ToyRobot::Utils::Compass.north)
    end
  end

  describe '#data' do
    it 'returns current direction in upper case format' do
      robot = instance_double('ToyRobot::Robot', brain: {
        initial: { direction: "NORTH"}
      })
      subject.attach(robot)

      expect(subject.data[:direction]).to eq("NORTH")
    end
  end
end
