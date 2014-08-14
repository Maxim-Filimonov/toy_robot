module ToyRobot
  module Utils
    class Location
      attr_reader :x, :y, :direction
      def initialize(args={})
        @x = args.fetch(:x)
        @y = args.fetch(:y)
        @direction = args.fetch(:direction)
      end

      def create(args={})
        defaults = {x: x, y: y, direction: direction}
        args = defaults.merge(args)
        ToyRobot::Utils::Location.new(args)
      end

      def eql?(other)
        x == other.x &&
        y == other.y &&
        direction == other.direction
      end

      def to_s
        "Location #{x}, #{y} facing #{direction}"
      end
    end
  end
end
