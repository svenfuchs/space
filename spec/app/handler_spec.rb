require 'spec_helper'

describe Space::App::Handler do
  let(:project) { stub('project') }
  let(:handler) { Space::App::Handler.new(project) }

  def command_for(command)
     handler.send(:command_for, nil, command)
  end

  describe 'command_for' do
    it 'returns a Command::Refresh instance for an empty command string' do
      command_for('refresh').should be_a(Space::App::Command::Refresh)
    end

    it 'returns a Command::Scope instance for an empty command string' do
      command_for('').should be_a(Space::App::Command::Scope)
    end

    it 'returns a Command::Unscope instance for "-"' do
      command_for('-').should be_a(Space::App::Command::Unscope)
    end

    it 'returns a Command::Execute instance for "ls -al"' do
      command_for('ls -al').should be_a(Space::App::Command::Execute)
    end
  end
end
