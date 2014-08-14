module ToyRobot
  module Commands
    class MoveCommand
      attr_reader :raw_command
      def initialize(raw_command)
        @raw_command = raw_command
      end

      def valid?
        raw_command == "MOVE"
      end

      def execute(robot)
        robot.move_forward
      end
    end
  end
end
