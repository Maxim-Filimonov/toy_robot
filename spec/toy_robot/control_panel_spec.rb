require 'toy_robot/control_panel'

describe ToyRobot::ControlPanel do
  let(:robot_class) { class_double('ToyRobot::Robot') }
  subject(:panel) { described_class.new(robot_class: robot_class)}
  describe '#run' do
    context 'invalid command' do
    end

    context 'placement commands' do
      it 'sends placement command to robot' do
        expect(robot_class).to receive(:place).with(place_x: 0,place_y: 0,direction: "N")

        panel.run("PLACE 0,0,NORTH")
      end

      it 'does not create another robot when one already exists' do
        allow(robot_class).to receive(:place).and_return(:robot)
        panel.run("PLACE 0,0,NORTH")

        expect(robot_class).to_not receive(:place)

        panel.run("PLACE 0,0,NORTH")
      end
    end

  end
end
