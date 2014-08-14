require 'toy_robot/commands/null_command'

describe ToyRobot::Commands::NullCommand do
  subject { described_class.new("BOGUS")}

  it 'is always valid' do
    subject.valid?
  end

  it 'can be executed' do
    expect { subject.execute(:robot) }.to_not raise_error
  end
end
