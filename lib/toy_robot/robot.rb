require 'toy_robot/systems/chassis_system'

module ToyRobot
  class Robot
    DEFAULT_MAX_X = 5
    DEFAULT_MAX_Y = 5

    attr_reader :movement_system, :sensors, :brain
    def initialize(opts={})
      @sensors = opts.delete(:sensors) || default_sensors
      @movement_system = opts.delete(:movement_system) || default_movement_system
      @brain = {initial: opts}

      sensors.each {|sen| sen.attach(self) }
      movement_system.attach(self)
    end

    def default_sensors
      []
    end

    def default_movement_system
      ToyRobot::Systems::ChassisSystem.new
    end

    def self.place(opts={})
      defaults = { max_x: DEFAULT_MAX_X, max_y: DEFAULT_MAX_X }
      opts = defaults.merge(opts)
      if pre_flight_checks_passed?(opts)
        self.new(opts)
      else
        nil
      end
    end

    def self.pre_flight_checks_passed?(opts)
      x = opts.fetch(:place_x)
      y = opts.fetch(:place_y)
      inside_boundaries = (0..opts[:max_x]).include?(x) && (0..opts[:max_y]).include?(y)
    end

    def move_forward
      movement_allowed = sensors.all? { |sen| sen.can?(:move) }
      if movement_allowed
        movement_system.move_forward
      end
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
