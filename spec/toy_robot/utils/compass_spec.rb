require 'toy_robot/utils/compass'

describe ToyRobot::Utils::Compass do

  describe '#left_from' do
    [[:north, :west], [:west, :south], [:south, :east], [:east, :north]].each do |test_data|
      it 'returns next anticlockwise direction' do
        expect(described_class.left_from(test_data[0])).to eq(test_data[1])
      end
    end
  end

  describe '#right_from' do
    [[:north, :east], [:east, :south], [:south, :west], [:west, :north]].each do |test_data|
      it 'returns next clockwise direction' do
        expect(described_class.right_from(test_data[0])).to eq(test_data[1])
      end
    end
  end

  describe '#to_direction' do
    it 'converts upper case direction to correct symbol' do
      converted_direction = described_class.to_direction 'NORTH'
      expect(converted_direction).to eq(described_class.north)
    end
  end
end
