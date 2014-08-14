require 'toy_robot/commands/move_command'

describe ToyRobot::Commands::MoveCommand do
  context 'with valid raw command' do
    subject { described_class.new("MOVE")}

    its(:valid?) { is_expected.to eq(true) }

    describe '#execute' do
      it 'moves robot forward' do
        robot = instance_double('ToyRobot::Robot')

        expect(robot).to receive(:move_forward)

        subject.execute(robot)
      end
    end
  end

  context 'with invalid command' do
    subject { described_class.new("BOGUS")}

    its(:valid?) { is_expected.to eq(false) }
  end
end
