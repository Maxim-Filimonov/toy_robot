require 'toy_robot/commands/right_command'

describe ToyRobot::Commands::RightCommand do
  context 'with valid raw command' do
    subject { described_class.new("RIGHT") }

    its(:valid?) { is_expected.to eq(true) }

    describe '#execute' do
      it 'rotate robot anticlockwise' do
        robot = instance_double('ToyRobot::Robot')

        expect(robot).to receive(:rotate_clockwise)

        subject.execute(robot)
      end
    end
  end

  context 'with invalid command' do
    subject { described_class.new("BOGUS") }

    its(:valid?) { is_expected.to eq(false) }
  end
end
