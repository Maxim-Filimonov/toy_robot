require 'toy_robot/control_panel'
require 'support/fake_display'

# Corresponds to Example B
describe 'Robot rotation' do
  subject(:panel) { ToyRobot::ControlPanel.new(display: FakeDisplay.new) }
  it 'can rotate to the left from north' do
    panel.run("PLACE 0,0,NORTH")
    panel.run("LEFT")
    panel.run("REPORT")

    expect(panel.display.gets).to eq('0,0,WEST')
  end

  it 'can rotate to the right from north' do
    panel.run("PLACE 0,0,NORTH")
    panel.run("RIGHT")
    panel.run("REPORT")

    expect(panel.display.gets).to eq('0,0,EAST')

  end

  it 'can rotate 360 degrees to the right' do
    panel.run("PLACE 0,0,NORTH")
    panel.run("RIGHT")
    panel.run("RIGHT")
    panel.run("RIGHT")
    panel.run("RIGHT")
    panel.run("REPORT")

    expect(panel.display.gets).to eq('0,0,NORTH')
  end

  it 'can rotate 360 degrees to the left' do
    panel.run("PLACE 0,0,NORTH")
    panel.run("LEFT")
    panel.run("LEFT")
    panel.run("LEFT")
    panel.run("LEFT")
    panel.run("REPORT")

    expect(panel.display.gets).to eq('0,0,NORTH')
  end
end
