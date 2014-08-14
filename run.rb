#!/usr/bin/env ruby
file_expand_path = File.expand_path('./lib', File.dirname(__FILE__))
$:.unshift(file_expand_path)

require 'highline/import'
require 'toy_robot/control_panel'

say "===Welcome to Toy Robot Simulator==="
say "========================================"
control_panel = ToyRobot::ControlPanel.new
loop do
  cmd = ask("Enter the command: ") do |q|
    q.readline = true
    q.case = :up
  end
  break if %w(QUIT EXIT).include? cmd
  control_panel.run(cmd)
end

