require 'spec_helper'

module Mock
  module Source
    def path
      '.'
    end
  end
end

describe Space::Source::Command do
  include Mock::Source

  let(:command) { Space::Source::Command.new(self, 'echo "FOO"') }

  # describe 'run' do
  #   subject { command.run }

  #   it 'runs the command' do
  #     should == 'FOO'
  #   end

  #   it 'switches to the context directory' do
  #     Dir.expects(:chdir).with('.').returns('bar')
  #     should == 'bar'
  #   end

  #   it 'clears the bundler env' do
  #     Bundler.expects(:with_clean_env).returns('bar')
  #     should == 'bar'
  #   end

  #   it 'notifies the context about changes' do
  #     subject
  #     events.should include(['echo "FOO"', 'FOO'])
  #   end
  # end
end
