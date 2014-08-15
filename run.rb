#!/usr/bin/env ruby
file_expand_path = File.expand_path('./lib', File.dirname(__FILE__))
$:.unshift(file_expand_path)

require 'highline/import'
require 'toy_robot/control_panel'
require 'yaml'

say "===Welcome to Toy Robot Simulator==="
say "========================================"
control_panel = ToyRobot::ControlPanel.new
choose do |menu|
  menu.prompt = "Please, choice from one of the options above"

  menu.choice "Test data from file (test_data.yml)" do
    examples = YAML.load_file("./test_data.yml")
    say "Available examples #{examples.keys}"
    example = ask("Which example do you want to run?") do |q|
      q.readline = true
      q.case = :down
    end
    commands = examples[example]
    if commands
      commands.each do |cmd|
        say "Running: #{cmd}"
        control_panel.run(cmd)
      end
    else
      say "Example #{example} not found..."
    end
  end

  menu.choice "Manual control" do
    loop do
      cmd = ask("Enter the command: ") do |q|
        q.readline = true
        q.case = :up
      end
      break if %w(QUIT EXIT).include? cmd
      control_panel.run(cmd)
    end
  end
end

