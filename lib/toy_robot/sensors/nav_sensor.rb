require 'toy_robot/utils/compass'

module ToyRobot
  module Sensors
    class NavSensor
      attr_reader :robot, :distances
      def initialize
        @distances = Hash[*ToyRobot::Utils::Compass.cordinal_directions.map { |d| [d, 0] }.flatten]
      end

      ToyRobot::Utils::Compass.cordinal_directions.each do |cordinal|
        define_method "steps_left_to_#{cordinal}_border" do
          distances[cordinal]
        end
      end

      def detect_borders(options)
        distances[ToyRobot::Utils::Compass.north] = options[:boundary_y] - options[:placement_y] - 1
        distances[ToyRobot::Utils::Compass.east] = options[:boundary_x] - options[:placement_x] - 1
        distances[ToyRobot::Utils::Compass.west] = options[:placement_x]
        distances[ToyRobot::Utils::Compass.south] = options[:placement_y]
      end

      def attach(robot)
        @robot = robot
      end

      def update(direction)
        distances[direction] -= 1
        distances[ToyRobot::Utils::Compass.opposite(direction)] += 1
      end

      def can?(action)
        if action == :move
          direction = robot.brain[:current_direction]
          puts robot.brain.inspect
          distances[direction] > 0
        end
      end

      def name
        :nav
      end

      def data
        {
          x: distances[ToyRobot::Utils::Compass.west],
          y: distances[ToyRobot::Utils::Compass.south]
        }
      end
    end
  end
end
