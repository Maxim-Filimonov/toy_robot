require 'toy_robot/control_panel'

describe ToyRobot::ControlPanel do
  let(:init_blueprint) { class_double('ToyRobot::Commands::ParseCommand') }
  subject(:panel) { described_class.new(init_blueprints: [init_blueprint])}

  describe '#run' do
    context 'invalid command' do
    end

    describe 'init commands' do
      let(:valid_command)  { instance_double('ToyRobot::Commands::ParseCommand', valid?: true) }
      before do
        allow(init_blueprint).to receive(:new).and_return(valid_command)
      end
      it 'finds valid init command' do
        raw_command = "SOME INIT COMMAND"
        expect(init_blueprint).to receive(:new).with(raw_command)
        expect(valid_command).to receive(:execute)

        panel.run(raw_command)
      end

      it 'does not create another robot when one already exists' do
        allow(valid_command).to receive(:execute).and_return(:robot)
        panel.run("PLACE 0,0,NORTH")

        expect(valid_command).to_not receive(:execute)

        panel.run("PLACE 0,0,NORTH")
      end
    end

  end
end
