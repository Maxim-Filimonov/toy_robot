require 'toy_robot/utils/compass'

describe ToyRobot::Utils::Compass do

  describe '#opposite' do
    [[:north, :south], [:west, :east], [:south, :north], [:east, :west]].each do |test_data|
      it 'indicates correct opposite direction' do
        opposite = described_class.opposite test_data[0]
        expect(opposite).to eq(test_data[1])
      end
    end
  end

  describe '#left_from' do
    [[:north, :west], [:west, :south], [:south, :east], [:east, :north]].each do |test_data|
      it 'returns next anticlockwsise direction' do
        expect(described_class.left_from(test_data[0])).to eq(test_data[1])
      end
    end
  end

  describe '#right_from' do
    [[:north, :east], [:east, :south], [:south, :west], [:west, :north]].each do |test_data|
      it 'returns next clockwsise direction' do
        expect(described_class.right_from(test_data[0])).to eq(test_data[1])
      end
    end
  end

  describe '#to_direction' do
    it 'converts upper case directionion to correct symbol' do
      converted_direction = described_class.to_direction 'NORTH'
      expect(converted_direction).to eq(described_class.north)
    end
  end
end
