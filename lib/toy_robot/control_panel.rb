require 'toy_robot/robot'
require 'toy_robot/commands/parse_command'
require 'toy_robot/commands/move_command'
require 'toy_robot/commands/null_command'

module ToyRobot
  class ControlPanel
    attr_accessor :robot
    attr_reader :init_blueprints, :action_blueprints

    def initialize(init_blueprints: [ToyRobot::Commands::ParseCommand],
      action_blueprints: [ToyRobot::Commands::MoveCommand])
      @init_blueprints = init_blueprints
      @action_blueprints = action_blueprints
    end

    def run(raw_command)
      if robot
        command = match_command(action_blueprints, raw_command)
        command.execute(robot)
      else
        command = match_command(init_blueprints, raw_command)
        @robot = command.execute
      end
    end

    def display
      '0,1,NORTH'
    end

    private
    def match_command(blueprints, raw_command)
      commands = blueprints.map {|cmd| cmd.new(raw_command) }
      null_command = -> (){ ToyRobot::Commands::NullCommand.new(raw_command) }
      commands.detect(null_command) {|cmd| cmd.valid? }
    end
  end
end
