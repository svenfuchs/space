require 'spec_helper'

describe Action do
  let(:names) { %w(travis-ci) }

  describe 'parse_repo' do
    it 'detects a repo by name' do
      repo, command = Action.parse_repo(names, 'travis-ci')
      repo.should == 'travis-ci'
    end

    it 'removes the detected repo name from the given line (given a name)' do
      line = 'travis-ci'
      Action.parse_repo(names, line)
      line.should == ''
    end

    it 'detects a repo by number' do
      repo, command = Action.parse_repo(names, '1')
      repo.should == 'travis-ci'
    end

    it 'removes the detected repo name from the given line (given a number)' do
      line = '1'
      Action.parse_repo(names, line)
      line.should == ''
    end

    it 'returns nil if no repo could be detected' do
      repo, command = Action.parse_repo(names, '-')
      repo.should == nil
    end

    it 'does not touch the given line if no repo could be detected' do
      line = '-'
      Action.parse_repo(names, line)
      line.should == '-'
    end
  end

  describe 'parse' do
    it 'returns "travis-ci", "" for "travis-ci"' do
      Action.parse(names, 'travis-ci').should == ['travis-ci', '']
    end

    it 'returns "travis-ci", "reload" for "travis-ci reload"' do
      Action.parse(names, 'travis-ci reload').should == ['travis-ci', 'reload']
    end

    it 'returns "travis-ci", "" for "1"' do
      Action.parse(names, '1').should == ['travis-ci', '']
    end

    it 'returns "travis-ci", "reload" for "1 reload"' do
      Action.parse(names, '1 reload').should == ['travis-ci', 'reload']
    end

    it 'returns nil, "reload" for "reload"' do
      Action.parse(names, 'reload').should == [nil, 'reload']
    end
  end
end
