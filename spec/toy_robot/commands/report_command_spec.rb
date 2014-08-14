require 'toy_robot/commands/report_command'

describe ToyRobot::Commands::ReportCommand do
  context 'with valid raw command' do
    subject { described_class.new('REPORT') }

    its(:valid?) { is_expected.to eq(true) }

    describe '#execute' do
      it 'returns nav and compass part of robot report' do
        robot = instance_double('ToyRobot::Robot')

        allow(robot).to receive(:report).and_return(
                          nav: {
                            x: 1,
                            y: 2
                          },
                          compass: {
                            direction: "NORTH"
                          }
                        )
        result = subject.execute(robot)
        expect(result).to eq("1,2,NORTH")
      end
    end
  end

  context 'with bogus raw command' do
    subject { described_class.new('BOGUS') }

    its(:valid?) { is_expected.to eq(false) }
  end
end
