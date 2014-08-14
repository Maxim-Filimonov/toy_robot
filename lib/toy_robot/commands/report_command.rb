module ToyRobot
  module Commands
    class ReportCommand
      attr_reader :raw_command

      def initialize(raw_command)
        @raw_command = raw_command
      end

      def valid?
        raw_command == "REPORT"
      end

      def execute(robot)
        report = robot.report
        nav_data = report.fetch(:nav)
        compass_data = report.fetch(:compass)

        [
          nav_data[:x],
          nav_data[:y],
          compass_data[:direction]
        ].join(",")
      end

    end
  end
end
