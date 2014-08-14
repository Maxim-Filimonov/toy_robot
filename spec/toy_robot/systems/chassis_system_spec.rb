require 'toy_robot/systems/chassis_system'
require 'toy_robot/utils/location'

describe ToyRobot::Systems::ChassisSystem do
  describe '#request_move_forward' do
    it 'can move to north' do
      robot = instance_double('ToyRobot::Robot', brain: {
        current_location:  ToyRobot::Utils::Location.new(x: 0, y: 0, direction: ToyRobot::Utils::Compass.north) })
      subject.attach(robot)

      subject.request_move_forward

      new_location = robot.brain[:target_location]
      expect(new_location.x).to eq(0)
      expect(new_location.y).to eq(1)
    end
  end
  describe '#request_rotate_anticlockwise' do
    it 'rotates from north to west' do
      robot = instance_double('ToyRobot::Robot', brain: {
        current_location:  ToyRobot::Utils::Location.new(x: 0, y: 0, direction: ToyRobot::Utils::Compass.north) })
      subject.attach(robot)

      subject.request_rotate_anticlockwise

      new_location = robot.brain[:target_location]
      expect(new_location.direction).to eq(ToyRobot::Utils::Compass.west)
    end
  end

  describe '#move' do
    it 'replaces current location with target location' do
      target_location = ToyRobot::Utils::Location.new(x: 0, y: 1, direction: ToyRobot::Utils::Compass.north)
      robot = instance_double('ToyRobot::Robot', brain: {
        current_location:  ToyRobot::Utils::Location.new(x: 0, y: 0, direction: ToyRobot::Utils::Compass.north) ,
        target_location: target_location })
      subject.attach(robot)

      subject.move

      current_location = robot.brain[:current_location]
      expect(current_location).to eql(target_location)
    end
  end
end
