require 'toy_robot/commands/left_command'

describe ToyRobot::Commands::LeftCommand do
  context 'with valid raw command' do
    subject { described_class.new("LEFT")}

    its(:valid?) { is_expected.to eq(true) }

    describe '#execute' do
      it 'rotate robot anticlockwise' do
        robot = instance_double('ToyRobot::Robot')

        expect(robot).to receive(:rotate_anticlockwise)

        subject.execute(robot)
      end
    end
  end

  context 'with invalid command' do
    subject { described_class.new("BOGUS")}

    its(:valid?) { is_expected.to eq(false) }
  end
end
