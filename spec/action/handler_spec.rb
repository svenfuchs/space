require 'spec_helper'

describe Space::Action::Handler do
  let(:repos)   { stub('repos', scope: stub('collection', self_and_deps: [])) }
  let(:project) { stub('project', repos: repos) }
  let(:handler) { Space::Action::Handler.new(project) }

  def action_for(command)
     handler.send(:action_for, nil, command)
  end

  describe 'action_for' do
    it 'returns a Command::Refresh instance for an empty command string' do
      action_for('refresh').should be_a(Space::Action::Refresh)
    end

    it 'returns a Command::Scope instance for an empty command string' do
      action_for('').should be_a(Space::Action::Scope)
    end

    it 'returns a Command::Unscope instance for "-"' do
      action_for('-').should be_a(Space::Action::Unscope)
    end

    it 'returns a Command::Execute instance for "ls -al"' do
      action_for('ls -al').should be_a(Space::Action::Execute)
    end
  end
end
