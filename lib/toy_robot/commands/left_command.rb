module ToyRobot
  module Commands
    class LeftCommand
      attr_reader :raw_command
      def initialize(raw_command)
        @raw_command = raw_command
      end

      def valid?
        raw_command == "LEFT"
      end

      def execute(robot)
        robot.rotate_anticlockwise()
      end
    end
  end
end
