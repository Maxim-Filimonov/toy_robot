module ToyRobot
  module Commands
    class NullCommand
      attr_reader :raw_command

      def initialize(raw_command)
        @raw_command = raw_command
      end

      def valid?
        false
      end

      def execute(_=nil)
        "UNRECOGNIZED COMMAND - #{raw_command}"
      end
    end
  end
end
