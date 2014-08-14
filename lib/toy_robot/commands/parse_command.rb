require 'ostruct'
module ToyRobot
  module Commands
    class ParseCommand

      def self.parse(raw_command)
        OpenStruct.new(valid?: true, parsed:
        {
          direction: "NORTH", place_x: 0, place_y: 0 })
      end

    end
  end
end
