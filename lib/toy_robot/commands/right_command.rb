module ToyRobot
  module Commands
    class RightCommand
      attr_reader :raw_command
      def initialize(raw_command)
        @raw_command = raw_command
      end

      def valid?
        raw_command == "RIGHT"
      end

      def execute(robot)
        robot.rotate_clockwise
      end
    end
  end
end
