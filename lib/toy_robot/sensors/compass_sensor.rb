require 'toy_robot/utils/compass'

module ToyRobot
  module Sensors
    class CompassSensor

      def attach(robot)
        direction = Utils::Compass.to_direction(robot.brain[:initial][:direction])
        robot.brain[:current_direction] = direction
      end
    end
  end
end
