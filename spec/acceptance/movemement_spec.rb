require 'toy_robot/control_panel'
require 'support/fake_display'

# Corresponds to Example a
describe 'Robot movements' do
  subject(:panel) { ToyRobot::ControlPanel.new(display: FakeDisplay.new) }
  it 'can move one step to the north' do
    panel.run("PLACE 0,0,NORTH")
    panel.run("MOVE")
    panel.run("REPORT")

    expect(panel.display.gets).to eq('0,1,NORTH')
  end
end
