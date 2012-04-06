require 'spec_helper'

class Shell
  include Space::Shell
  commands :list => 'ls -al'
end

describe Space::Shell do
  let(:shell) {  Shell.new('path') }

  describe '.commands' do
    it 'defines the commands this class cares about' do
      Shell.commands[:list].should == 'ls -al'
    end
  end

  describe 'initialize' do
    it 'registers the consumer class to Space::Shell.all' do
      Space::Shell.all.should include(shell)
    end
  end

  describe 'commands' do
    it 'returns a hash holding command instances' do
      shell.commands[:list].command.should == 'ls -al'
    end
  end
end
