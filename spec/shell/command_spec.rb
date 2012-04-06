require 'spec_helper'

module Mock
  module Shell
    def events
      @events ||= []
    end

    def notify(event, data)
      events << [event, data]
    end

    def path
      '.'
    end
  end
end

describe Space::Shell::Command do
  include Mock::Shell

  let(:command) { Space::Shell::Command.new(self, 'echo "FOO"') }

  describe 'run' do
    subject { command.run }

    it 'runs the command' do
      should == 'FOO'
    end

    it 'switches to the context directory' do
      Dir.expects(:chdir).with('.').returns('bar')
      should == 'bar'
    end

    it 'clears the bundler env' do
      Bundler.expects(:with_clean_env).returns('bar')
      should == 'bar'
    end

    it 'notifies the context about changes' do
      subject
      events.should include(['echo "FOO"', 'FOO'])
    end
  end
end
