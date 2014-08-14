require 'toy_robot/robot'
require 'toy_robot/commands/parse_command'

module ToyRobot
  class ControlPanel
    attr_reader :robot, :init_blueprints

    def initialize(init_blueprints: [ToyRobot::Commands::ParseCommand])
      @init_blueprints = init_blueprints
    end

    def run(command)
      if robot
        # Interaction with action command
      else
        @robot = init_robot(command)
      end
    end

    def init_robot(command)
      init_commands = init_blueprints.map {|cmd| cmd.new(command) }
      command = init_commands.detect {|cmd| cmd.valid? }
      command.execute
    end

    def display
      '0,1,NORTH'
    end
  end
end
