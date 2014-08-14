require 'toy_robot/utils/compass'
require 'toy_robot/utils/location'

module ToyRobot
  module Sensors
    class CompassSensor
      attr_reader :robot

      def attach(robot)
        @robot = robot
      end

      def name
        :compass
      end

      def can?(_)
        true
      end

      def data
        {
          direction: robot.brain[:current_location].direction.upcase.to_s
        }
      end
    end
  end
end
