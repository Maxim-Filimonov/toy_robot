require 'toy_robot/utils/compass'
require 'toy_robot/utils/location'

module ToyRobot
  module Sensors
    class NavSensor
      attr_reader :robot, :frame

      def attach(robot)
        @robot = robot
        initial_location = robot.brain[:initial]
        current_location = ToyRobot::Utils::Location.new(x: initial_location[:place_x], y: initial_location[:place_y],
                                                         direction: ToyRobot::Utils::Compass.to_direction(initial_location[:direction]))
        @frame = {
          x: 0..robot.brain[:initial][:boundary_x],
          y: 0..robot.brain[:initial][:boundary_y]
        }

        robot.brain[:current_location] = current_location
      end

      def can?(action)
        if action == :move
          target = robot.brain[:target_location]
          frame[:x].include?(target.x) && frame[:y].include?(target.y)
        end
      end

      def name
        :nav
      end

      def data
        {
          x: robot.brain[:current_location].x,
          y: robot.brain[:current_location].y
        }
      end
    end
  end
end
