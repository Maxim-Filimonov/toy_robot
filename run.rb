#!/usr/bin/env ruby
file_expand_path = File.expand_path('./lib', File.dirname(__FILE__))
puts file_expand_path
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
  break if ["QUIT", "EXIT"].include? cmd
  control_panel.run(cmd)
  # if command
  #   result = command.execute()
  #   say result if result.respond_to? :to_str
  # else
  #   say "Unrecognized command #{cmd}. Use help to get list of available commands"
  # end
end

