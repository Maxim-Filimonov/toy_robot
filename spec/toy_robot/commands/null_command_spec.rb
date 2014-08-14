require 'toy_robot/commands/null_command'

describe ToyRobot::Commands::NullCommand do
  subject { described_class.new("BOGUS") }

  it 'is never valid' do
    expect(subject.valid?).to eq(false)
  end

  it 'returns unrecognized command' do
    expect(subject.execute).to eq("UNRECOGNIZED COMMAND - BOGUS")
  end
end
