module ToyRobot
  module Utils
    class Compass
      CORDINAL_DIRECTIONS = [:north, :east, :south, :west]

      def self.cordinal_directions
        CORDINAL_DIRECTIONS
      end

      CORDINAL_DIRECTIONS.each do |direction|
        self.class.class_eval do
          define_method direction do
            direction
          end
        end
      end

      def self.opposite(direction)
        index = CORDINAL_DIRECTIONS.index(direction)
        index += 2
        direction_by_index(index)
      end

      def self.left_from(direction)
        index = CORDINAL_DIRECTIONS.index(direction)
        index -= 1
        direction_by_index(index)
      end

      def self.right_from(direction)
        index = CORDINAL_DIRECTIONS.index(direction)
        index += 1
        direction_by_index(index)
      end

      def self.to_direction(string_direction)
        self.send(string_direction.downcase.to_sym)
      end

      private
      def self.direction_by_index(index)
        if index >= CORDINAL_DIRECTIONS.length
          CORDINAL_DIRECTIONS[index - CORDINAL_DIRECTIONS.length]
        elsif index < 0
          CORDINAL_DIRECTIONS[CORDINAL_DIRECTIONS.length + index]
        else
          CORDINAL_DIRECTIONS[index]
        end
      end
    end
    
  end
end
