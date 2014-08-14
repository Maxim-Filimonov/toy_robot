require 'toy_robot/robot'
require 'toy_robot/commands/parse_command'
require 'toy_robot/commands/move_command'
require 'toy_robot/commands/null_command'

module ToyRobot
  class ControlPanel
    attr_accessor :robot
    attr_reader :init_blueprints, :action_blueprints, :display

    def initialize(init_blueprints: default_init_blueprints,
      action_blueprints: default_action_blueprints)
      @init_blueprints = init_blueprints
      @action_blueprints = action_blueprints
    end

    def default_init_blueprints
      [ToyRobot::Commands::ParseCommand]
    end

    def default_action_blueprints
        [
          ToyRobot::Commands::MoveCommand,
          ToyRobot::Commands::ReportCommand
        ]
    end

    def run(raw_command)
      if robot
        command = match_command(action_blueprints, raw_command)
        result = command.execute(robot)
        if result
          @display = result
        end
      else
        command = match_command(init_blueprints, raw_command)
        @robot = command.execute
      end
    end

    private
    def match_command(blueprints, raw_command)
      commands = blueprints.map {|cmd| cmd.new(raw_command) }
      null_command = -> (){ ToyRobot::Commands::NullCommand.new(raw_command) }
      commands.detect(null_command) {|cmd| cmd.valid? }
    end
  end
end
