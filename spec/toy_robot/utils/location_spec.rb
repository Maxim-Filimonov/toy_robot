require 'toy_robot/utils/location'

describe ToyRobot::Utils::Location do
  describe '#create' do
    it 'create the same location when no args supplied' do
      loc = described_class.new(x: 0, y:0, direction: "N")

      new_location = loc.create

      expect(new_location).to eql(loc)
    end

    it 'allows to use arguments to move location' do
      loc = described_class.new(x: 0, y:0, direction: "N")

      new_location = loc.create(x: 5)

      expect(new_location).to_not eql(loc)
      expect(new_location.x).to eql(5)
    end
  end
end
