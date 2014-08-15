module ToyRobot
  module Utils
    class Compass
      CARDINAL_DIRECTIONS = [:north, :east, :south, :west]

      class << self
        def cardinal_directions
          CARDINAL_DIRECTIONS
        end

        def north
          CARDINAL_DIRECTIONS[0]
        end

        def east
          CARDINAL_DIRECTIONS[1]
        end

        def south
          CARDINAL_DIRECTIONS[2]
        end

        def west
          CARDINAL_DIRECTIONS[3]
        end

        def left_from(direction)
          index = CARDINAL_DIRECTIONS.index(direction)
          index -= 1
          direction_by_index(index)
        end

        def right_from(direction)
          index = CARDINAL_DIRECTIONS.index(direction)
          index += 1
          direction_by_index(index)
        end

        def to_direction(string_direction)
          self.send(string_direction.downcase.to_sym)
        end

        private
        def direction_by_index(index)
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
end
