require 'toy_robot/control_panel'

describe ToyRobot::ControlPanel do

  describe '#run' do
    describe 'init commands' do
      subject(:panel) { described_class.new(init_blueprints: [init_blueprint], display: double(:display, puts: true)) }
      let(:init_blueprint) { class_double('ToyRobot::Commands::ParseCommand') }
      let(:valid_command) { instance_double('ToyRobot::Commands::ParseCommand', valid?: true) }

      before do
        allow(init_blueprint).to receive(:new).and_return(valid_command)
      end

      it 'finds valid init command' do
        raw_command = "SOME INIT COMMAND"
        expect(init_blueprint).to receive(:new).with(raw_command)
        expect(valid_command).to receive(:execute)

        panel.run(raw_command)
      end

      it 'does not creates robot from null command' do
        raw_command = "SOME INIT COMMAND"
        expect(init_blueprint).to receive(:new).with(raw_command)
        allow(valid_command).to receive(:valid?).and_return(false)

        panel.run(raw_command)
        expect(panel.robot).to be_nil
      end

      it 'does not create another robot when one already exists' do
        allow(valid_command).to receive(:execute).and_return(:robot)
        panel.run("PLACE 0,0,NORTH")

        expect(valid_command).to_not receive(:execute)

        panel.run("PLACE 0,0,NORTH")
      end
    end

    describe 'action commands' do
      subject(:panel) { described_class.new(action_blueprints: [action_blueprint]) }
      let(:action_blueprint) { class_double('ToyRobot::Commands::MoveCommand') }
      let(:valid_command) { instance_double('ToyRobot::Commands::MoveCommand', valid?: true) }

      before do
        allow(action_blueprint).to receive(:new).and_return(valid_command)
      end

      before do
        panel.robot = :robot
      end

      it 'finds valid action command' do
        raw_command = "SOME COMMAND"
        expect(action_blueprint).to receive(:new).with(raw_command)
        expect(valid_command).to receive(:execute).with(:robot)

        panel.run(raw_command)
      end
    end

  end
end
