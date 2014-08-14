require 'toy_robot/commands/parse_command'

describe ToyRobot::Commands::ParseCommand do
  subject(:parse_command) { described_class }

  context 'when there are enough arguments' do
    it "can parse NORTH direction" do
      command_result = parse_command.parse('PLACE 0,0,NORTH')
      expect(command_result.parsed[:direction]).to eq("NORTH")
    end

    it "can parse initial coordinates" do
      command_result = parse_command.parse('PLACE 0,0,NORTH')
      expect(command_result.parsed[:place_x]).to eq(0)
      expect(command_result.parsed[:place_y]).to eq(0)
    end

    it 'indicates that parsing is valid' do
      command_result = parse_command.parse('PLACE 0,0,NORTH')
      expect(command_result).to be_valid
    end
  end
end
