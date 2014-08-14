module ToyRobot
  module Commands
    class NullCommand
      def initialize(raw_command)
      end

      def valid?
        true
      end

      def execute(args=nil)
      end
    end
  end
end
