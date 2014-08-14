require 'toy_robot/commands/parse_command'

describe ToyRobot::Commands::ParseCommand do
  context 'with valid raw command' do
    subject(:parse_command) { described_class.new("PLACE 1,2,NORTH") }

    its(:valid?) { is_expected.to eq(true) }

    describe '#result' do
      subject { parse_command.result }

      its([:direction]) { is_expected.to eq('NORTH')}
      its([:place_x]) { is_expected.to eq(1)}
      its([:place_y]) { is_expected.to eq(2)}
    end

    describe '#execute' do
      let(:robot_class) { class_double('ToyRobot::Robot') }

      it 'initialize a new robot' do
        expect(robot_class).to receive(:place).with(parse_command.result).and_return(:robot)

        result = parse_command.execute(robot_class: robot_class)

        expect(result).to eq(:robot)
      end
    end
  end

end
