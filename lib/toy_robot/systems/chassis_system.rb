require 'toy_robot/utils/compass'
module ToyRobot
  module Systems
    class ChassisSystem
      attr_reader :robot

      def request_move_forward
        location = robot.brain[:current_location]
        new_location = case location.direction
        when ToyRobot::Utils::Compass.north
          location.create(y: location.y + 1)
        end

        robot.brain[:target_location] = new_location
      end

      def move
        robot.brain[:current_location] = robot.brain[:target_location]
      end

      def face

      end

      def attach(robot)
        @robot = robot
      end
    end
  end
end
