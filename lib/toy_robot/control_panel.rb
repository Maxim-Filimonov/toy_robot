require 'toy_robot/robot'
module ToyRobot
  class ControlPanel
    attr_reader :robot_class
    attr_reader :robot

    # PLACE_CMD_REGEX = /PLACE\s\s*(?<x>\d+)\s*,\s*(?<y>\d+)\s*,\s*(?<direction>(NORTH|WEST|EAST|SOUTH))\s*/
    def initialize(robot_class: ToyRobot::Robot)
      @robot_class = robot_class
    end

    def run(command)
      unless robot
        @robot = @robot_class.place(place_x: 0, place_y: 0, direction: "N")
      end
    end

    def display
      '0,1,NORTH'
    end
  end
end
