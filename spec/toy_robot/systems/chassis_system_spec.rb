require 'toy_robot/systems/chassis_system'
require 'toy_robot/utils/location'

describe ToyRobot::Systems::ChassisSystem do
  describe 'movements' do
    let(:system) { described_class.new }
    let(:robot) { instance_double('ToyRobot::Robot', brain: {
      current_location: ToyRobot::Utils::Location.new(x: 1, y: 1, direction: initial_direction)}) }
    before do
      system.attach(robot)
    end

    subject { robot.brain[:target_location] }
    describe '#request_move_forward' do
      before do
        system.request_move_forward
      end

      context 'when moving to north' do
        let(:initial_direction) { ToyRobot::Utils::Compass.north }
        its(:x) { is_expected.to eq(1) }
        its(:y) { is_expected.to eq(2) }
      end

      context 'when moving to east' do
        let(:initial_direction) { ToyRobot::Utils::Compass.east }
        its(:x) { is_expected.to eq(2) }
        its(:y) { is_expected.to eq(1) }
      end

      context 'when moving to south' do
        let(:initial_direction) { ToyRobot::Utils::Compass.south }
        its(:x) { is_expected.to eq(1) }
        its(:y) { is_expected.to eq(0) }
      end

      context 'when moving to west' do
        let(:initial_direction) { ToyRobot::Utils::Compass.west }
        its(:x) { is_expected.to eq(0) }
        its(:y) { is_expected.to eq(1) }
      end
    end
    describe '#request_rotate_anticlockwise' do
      before do
        system.request_rotate_anticlockwise
      end

      context 'when rotating from north' do
        let(:initial_direction) { ToyRobot::Utils::Compass.north }
        its(:direction) { is_expected.to eq(ToyRobot::Utils::Compass.west) }
      end

      context 'when rotating from west' do
        let(:initial_direction) { ToyRobot::Utils::Compass.west }
        its(:direction) { is_expected.to eq(ToyRobot::Utils::Compass.south) }
      end

      context 'when rotating from east' do
        let(:initial_direction) { ToyRobot::Utils::Compass.east }
        its(:direction) { is_expected.to eq(ToyRobot::Utils::Compass.north) }
      end

      context 'when rotating from south' do
        let(:initial_direction) { ToyRobot::Utils::Compass.south }
        its(:direction) { is_expected.to eq(ToyRobot::Utils::Compass.east) }
      end
    end

    describe '#request_rotate_clockwise' do
      before do
        system.request_rotate_clockwise
      end

      context 'when rotating from north' do
        let(:initial_direction) { ToyRobot::Utils::Compass.north }
        its(:direction) { is_expected.to eq(ToyRobot::Utils::Compass.east) }
      end

      context 'when rotating from west' do
        let(:initial_direction) { ToyRobot::Utils::Compass.west }
        its(:direction) { is_expected.to eq(ToyRobot::Utils::Compass.north) }
      end

      context 'when rotating from east' do
        let(:initial_direction) { ToyRobot::Utils::Compass.east }
        its(:direction) { is_expected.to eq(ToyRobot::Utils::Compass.south) }
      end

      context 'when rotating from south' do
        let(:initial_direction) { ToyRobot::Utils::Compass.south }
        its(:direction) { is_expected.to eq(ToyRobot::Utils::Compass.west) }
      end
    end
  end

  describe '#move' do
    it 'replaces current location with target location' do
      target_location = ToyRobot::Utils::Location.new(x: 0, y: 1, direction: ToyRobot::Utils::Compass.north)
      robot = instance_double('ToyRobot::Robot', brain: {
        current_location: ToyRobot::Utils::Location.new(x: 0, y: 0, direction: ToyRobot::Utils::Compass.north),
        target_location: target_location})
      subject.attach(robot)

      subject.move

      current_location = robot.brain[:current_location]
      expect(current_location).to eql(target_location)
    end
  end
end
