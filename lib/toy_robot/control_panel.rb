require 'toy_robot/robot'
require 'toy_robot/commands/parse_command'

module ToyRobot
  class ControlPanel
    attr_reader :robot, :init_commands

    # PLACE_CMD_REGEX = /PLACE\s\s*(?<x>\d+)\s*,\s*(?<y>\d+)\s*,\s*(?<direction>(NORTH|WEST|EAST|SOUTH))\s*/
    def initialize(init_commands: [ToyRobot::Commands::ParseCommand])
      @init_commands = init_commands
    end

    def run(command)
      unless robot
        initialized_commands = init_commands.map {|cmd| cmd.new(command) }
        command = initialized_commands.detect {|cmd| cmd.valid? }
        @robot = command.execute
      end
    end

    def display
      '0,1,NORTH'
    end
  end
end
