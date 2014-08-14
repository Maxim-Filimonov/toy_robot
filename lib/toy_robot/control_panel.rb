require 'toy_robot/robot'
require 'toy_robot/commands/place_command'
require 'toy_robot/commands/move_command'
require 'toy_robot/commands/report_command'
require 'toy_robot/commands/left_command'
require 'toy_robot/commands/right_command'
require 'toy_robot/commands/null_command'

module ToyRobot
  class ControlPanel
    attr_accessor :robot
    attr_reader :init_blueprints, :action_blueprints, :display

    def initialize(init_blueprints: default_init_blueprints,
                   action_blueprints: default_action_blueprints, display: $stdout)
      @init_blueprints = init_blueprints
      @action_blueprints = action_blueprints
      @display = display
    end

    def default_init_blueprints
      [ToyRobot::Commands::ParseCommand]
    end

    def default_action_blueprints
      [
        ToyRobot::Commands::MoveCommand,
        ToyRobot::Commands::ReportCommand,
        ToyRobot::Commands::LeftCommand,
        ToyRobot::Commands::RightCommand,
      ]
    end

    def run(raw_command)
      if robot
        command = match_command(action_blueprints, raw_command)
        result = command.execute(robot)
        if result
          display.puts(result)
        end
      else
        command = match_command(init_blueprints, raw_command)
        if command.valid?
          @robot = command.execute
        end
      end
    end

    private
    def match_command(blueprints, raw_command)
      commands = blueprints.map { |cmd| cmd.new(raw_command) }
      null_command = -> () { ToyRobot::Commands::NullCommand.new(raw_command) }
      commands.detect(null_command) { |cmd| cmd.valid? }
    end
  end
end
