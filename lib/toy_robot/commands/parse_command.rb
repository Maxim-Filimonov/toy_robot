require 'ostruct'
module ToyRobot
  module Commands
    class ParseCommand

      def initialize(raw_command)
        @raw_command = raw_command
      end

      def valid?
        true
      end

      def result
        {
          direction: "NORTH", place_x: 0, place_y: 0
        }
      end

      def execute(robot_class: ToyRobot::Robot)
        robot_class.place(result)
      end

    end
  end
end
