require 'spec_helper'

class Source
  include Space::Source
  commands :list => 'ls -al'
end

describe Space::Source do
  let(:shell) {  Source.new('path') }

  describe '.commands' do
    it 'defines the commands this class cares about' do
      Source.commands[:list].should == 'ls -al'
    end
  end

  describe 'commands' do
    it 'returns a hash holding command instances' do
      shell.commands[:list].command.should == 'ls -al'
    end
  end
end
