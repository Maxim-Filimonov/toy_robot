require 'ostruct'
module ToyRobot
  module Commands
    class ParseCommand
      PLACE_CMD_REGEX = /PLACE\s\s*(?<x>\d+)\s*,\s*(?<y>\d+)\s*,\s*(?<direction>(NORTH|WEST|EAST|SOUTH))\s*/

      attr_reader :raw_command
      attr_reader :match

      def initialize(raw_command)
        @raw_command = raw_command
      end

      def valid?
        @match ||= raw_command.match(PLACE_CMD_REGEX)
        !!match
      end

      def result
        if valid?
          {
            direction: match[:direction], 
            place_x: match[:x].to_i,
            place_y: match[:y].to_i
          }
        else
          {}
        end
      end

      def execute(robot_class: ToyRobot::Robot)
        robot_class.place(result)
      end

    end
  end
end
