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
        when ToyRobot::Utils::Compass.east
          location.create(x: location.x + 1)
        when ToyRobot::Utils::Compass.south
          location.create(y: location.y - 1)
        else
          raise "Unrecognized #{location.direction}"
        end

        robot.brain[:target_location] = new_location
      end

      def request_rotate_anticlockwise
        location = robot.brain[:current_location]
        new_location = case location.direction
                       when ToyRobot::Utils::Compass.north
                         location.create(direction: ToyRobot::Utils::Compass.west)
                       when ToyRobot::Utils::Compass.west
                         location.create(direction: ToyRobot::Utils::Compass.south)
                       when ToyRobot::Utils::Compass.east
                         location.create(direction: ToyRobot::Utils::Compass.north)
                       else
                         raise "Unrecognized #{location.direction}"
                       end

        robot.brain[:target_location] = new_location
      end

      def request_rotate_clockwise
        location = robot.brain[:current_location]
        new_location = case location.direction
                       when ToyRobot::Utils::Compass.north
                         location.create(direction: ToyRobot::Utils::Compass.east)
                       when ToyRobot::Utils::Compass.west
                         location.create(direction: ToyRobot::Utils::Compass.north)
                       when ToyRobot::Utils::Compass.east
                         location.create(direction: ToyRobot::Utils::Compass.south)
                       when ToyRobot::Utils::Compass.south
                         location.create(direction: ToyRobot::Utils::Compass.west)
                       else
                         raise "Unrecognized #{location.direction}"
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
