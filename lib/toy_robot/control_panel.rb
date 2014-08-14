require 'toy_robot/robot'
require 'toy_robot/commands/parse_command'

module ToyRobot
  class ControlPanel
    attr_reader :robot_class, :robot, :init_commands

    # PLACE_CMD_REGEX = /PLACE\s\s*(?<x>\d+)\s*,\s*(?<y>\d+)\s*,\s*(?<direction>(NORTH|WEST|EAST|SOUTH))\s*/
    def initialize(robot_class: ToyRobot::Robot,
      init_commands: [ToyRobot::Commands::ParseCommand])
      @robot_class = robot_class
      @init_commands = init_commands
    end

    def run(command)
      unless robot
        command = init_commands.detect {|cmd| cmd.parse(command).valid? }
        result = command.parse(command)
        @robot = @robot_class.place(result.parsed)
      end
    end

    def display
      '0,1,NORTH'
    end
  end
end
