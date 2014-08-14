require 'toy_robot/control_panel'
require 'support/fake_display'

describe 'Robot combination of different movements' do
  subject(:panel) { ToyRobot::ControlPanel.new(display: FakeDisplay.new) }
  # Corresponds to Example C
  it 'can move and rotate' do
    panel.run("PLACE 1,2,EAST")
    panel.run("MOVE")
    panel.run("MOVE")
    panel.run("LEFT")
    panel.run("MOVE")
    panel.run("REPORT")

    expect(panel.display.gets).to eq('3,3,NORTH')
  end

end
