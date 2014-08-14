module ToyRobot
  class Robot
    def self.place(opts={})
      self.new
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

    private
    def initialise
    end

  end
end
