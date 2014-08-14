require 'toy_robot/robot'

describe ToyRobot::Robot do
  describe '.place' do
    describe 'pre-flight checks' do
      it 'does not allow to land outside of X coordinates' do
        robot = described_class.place(place_x: 6, place_y: 0, direction: "NORTH")
        expect(robot).to be_nil
      end

      it 'does not allow to land outside of Y coordinates' do
        robot = described_class.place(place_x: 0, place_y: 6, direction: "NORTH")
        expect(robot).to be_nil
      end

      it 'can land on the far edge' do
        robot = described_class.place(place_x: 5, place_y: 5, direction: "NORTH")
        expect(robot).to_not be_nil
      end
    end

    it 'initialises all sensors after landing' do
      sensor = instance_double('ToyRobot::Sensors::NavSensor')

      expect(sensor).to receive(:new).with(place_x: 1, place_y: 2, direction: "SOUTH")

      described_class.place(place_x: 1, place_y: 2, direction: "SOUTH", sensors: [sensor])
    end
  end
end
