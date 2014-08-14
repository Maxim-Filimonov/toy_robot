require 'toy_robot/utils/compass'

module ToyRobot
  module Sensors
    class CompassSensor
      attr_reader :robot

      def attach(robot)
        @robot = robot
        direction = Utils::Compass.to_direction(robot.brain[:initial][:direction])
        robot.brain[:current_direction] = direction
      end

      def name
        :compass
      end

      def data
        {
          direction: robot.brain[:current_direction].upcase.to_s
        }
      end
    end
  end
end
