require 'spec_helper'

describe Action::Parser do
  let(:names) { %w(travis-ci travis-core) }
  let(:parser) { Action::Parser.new(names) }

  describe 'parse' do
    it 'returns [["travis-ci"], nil] for "travis-ci"' do
      parser.parse('travis-ci').should == [['travis-ci'], nil]
    end

    it 'returns [["travis-ci"], "reload"] for "travis-ci reload"' do
      parser.parse('travis-ci reload').should == [['travis-ci'], 'reload']
    end

    it 'returns [["travis-ci", "travis-core"], "reload"] for "travis-ci travis-core reload"' do
      parser.parse('travis-ci travis-core reload').should == [['travis-ci', 'travis-core'], 'reload']
    end

    it 'returns [["travis-ci"], nil] for "1"' do
      parser.parse('1').should == [['travis-ci'], nil]
    end

    it 'returns [["travis-ci"], "reload"] for "1 reload"' do
      parser.parse('1 reload').should == [['travis-ci'], 'reload']
    end

    it 'returns [["travis-ci", "travis-core"], "reload"] for "1 2 reload"' do
      parser.parse('1 2 reload').should == [['travis-ci', 'travis-core'], 'reload']
    end

    it 'returns [nil, "reload"] for "reload"' do
      parser.parse('reload').should == [nil, 'reload']
    end
  end
end
