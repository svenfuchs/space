require 'spec_helper'

describe Git do
  let(:git) { Git.new('path/to/somewhere') }

  describe 'ahead?' do
    it 'returns true if ahead is greater than 0' do
      git.stubs(:ahead).returns(1)
      git.ahead?.should be_true
    end

    it 'returns false if ahead equals 0' do
      git.stubs(:ahead).returns(0)
      git.ahead?.should be_false
    end
  end

  describe 'ahead' do
    it "returns 2 if `git status` contains: ahead of '...' by 2 commits." do
      git.stubs(:result).with(:status).returns %(Your branch is ahead of 'origin/master' by 2 commits.\n\nnothing to commit (working directory clean))
      git.ahead.should == 2
    end

    it "returns 1 if `git status` contains: ahead of '...' by 1 commit." do
      git.stubs(:result).with(:status).returns %(Your branch is ahead of 'origin/master' by 1 commit.\n\nnothing to commit (working directory clean))
      git.ahead.should == 1
    end

    it "returns 0 if `git status` does not contain a line about commits ahead of a remote branch." do
      git.stubs(:result).with(:status).returns %(Your branch is nothing to commit (working directory clean))
      git.ahead.should == 0
    end
  end

  describe 'status' do

  end

  describe 'clean?' do
    it 'returns true if `git status` contains: nothing to commit' do
      git.stubs(:result).with(:status).returns 'nothing to commit (working directory clean)'
      git.clean?.should be_true
    end

    it 'returns false if `git status` does not contain: nothing to commit' do
      git.stubs(:result).with(:status).returns 'Changes not staged for commit:'
      git.clean?.should be_false
    end
  end

  describe 'branch' do
    it 'returns the current branch name from `git branch --no-color`'
  end

  describe 'commit' do
    it 'it returns the commit hash from `git log -1 head`'
  end
end

