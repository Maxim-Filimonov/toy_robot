require 'toy_robot/systems/chassis_system'

module ToyRobot
  class Robot
    MAX_X = 5
    MAX_Y = 5

    attr_reader :movement_system, :sensors
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
