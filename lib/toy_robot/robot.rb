module ToyRobot
  class Robot
    MAX_X = 5
    MAX_Y = 5
    def initialize(opts={})
      sensors = opts.delete(:sensors) || default_sensors
      @sensors = sensors.map {|sen| sen.new(opts) }
    end

    def default_sensors
      []
    end

    def self.place(opts={})
      if pre_flight_checks_passed?(opts)
        self.new(opts)
      else
        nil
      end
    end

    def self.pre_flight_checks_passed?(opts)
      x = opts.fetch(:place_x)
      y = opts.fetch(:place_y)
      inside_boundaries = (0..MAX_X).include?(x) && (0..MAX_Y).include?(y)
    end

    def move_forward
    end

    def report
      {
        nav: {
          x: 0,
          y: 1
        },
        compass: {
          direction: "NORTH"
        }
      }
    end


  end
end
