module ToyRobot
  module Utils
    class Compass
      CARDINAL_DIRECTIONS = [:north, :east, :south, :west]

      def self.cardinal_directions
        CARDINAL_DIRECTIONS
      end

      CARDINAL_DIRECTIONS.each do |direction|
        self.class.class_eval do
          define_method direction do
            direction
          end
        end
      end

      def self.opposite(direction)
        index = CARDINAL_DIRECTIONS.index(direction)
        index += 2
        direction_by_index(index)
      end

      def self.left_from(direction)
        index = CARDINAL_DIRECTIONS.index(direction)
        index -= 1
        direction_by_index(index)
      end

      def self.right_from(direction)
        index = CARDINAL_DIRECTIONS.index(direction)
        index += 1
        direction_by_index(index)
      end

      def self.to_direction(string_direction)
        self.send(string_direction.downcase.to_sym)
      end

      private
      def self.direction_by_index(index)
        if index >= CARDINAL_DIRECTIONS.length
          CARDINAL_DIRECTIONS[index - CARDINAL_DIRECTIONS.length]
        elsif index < 0
          CARDINAL_DIRECTIONS[CARDINAL_DIRECTIONS.length + index]
        else
          CARDINAL_DIRECTIONS[index]
        end
      end
    end
    
  end
end
