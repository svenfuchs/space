require 'spec_helper'

describe Space::Models::Repo::Git do
  GIT_RESULTS = {
    branch:       %(  feature\n* master\n),
    commit:       %(commit ce8fb952efdd29371ebdc572f8f47e59a9bd5ee5\nAuthor: Sven Fuchs <svenfuchs@artweb-design.de>\nDate:   Fri Apr 6 23:17:04 2012 +0200),
    status_clean: %(nothing to commit (working directory clean)),
    status_dirty: %(Changes not staged for commit:),
    ahead_by_2:   %(Your branch is ahead of 'origin/master' by 2 commits.\n\nnothing to commit (working directory clean)),
    ahead_by_1:   %(Your branch is ahead of 'origin/master' by 1 commit.\n\nnothing to commit (working directory clean)),
    ahead_by_0:   %(Your branch is nothing to commit (working directory clean))
  }

  let(:repo) { stub('repo', :path => '.') }
  let(:git)  { Space::Models::Repo::Git.new(repo) }

  def stub_command(command, result)
    git.commands[command].stubs(:result).returns GIT_RESULTS[result]
  end

  it 'branch returns the git branch' do
    stub_command :branch, :branch
    git.branch.should == 'master'
  end

  it 'commit returns the git commit' do
    stub_command :commit, :commit
    git.commit.should == 'ce8fb95'
  end

  describe 'status' do
    it 'returns :dirty if the working directory is dirty' do
      stub_command :status, :status_dirty
      git.status.should == :dirty
    end

    it 'returns :ahead if the repository is ahead of origin' do
      stub_command :status, :ahead_by_1
      git.status.should == :ahead
    end

    it 'returns :clean if the working directory is clean and the repository not ahead of origin' do
      stub_command :status, :status_clean
      git.status.should == :clean
    end
  end

  describe 'ahead?' do
    it 'returns true if ahead is greater than 0' do
      stub_command :status, :ahead_by_1
      git.ahead?.should be_true
    end

    it 'returns false if ahead equals 0' do
      stub_command :status, :ahead_by_0
      git.ahead?.should be_false
    end
  end

  describe 'ahead' do
    it "returns 2 if `git status` contains: ahead of '...' by 2 commits." do
      stub_command :status, :ahead_by_2
      git.ahead.should == 2
    end

    it "returns 1 if `git status` contains: ahead of '...' by 1 commit." do
      stub_command :status, :ahead_by_1
      git.ahead.should == 1
    end

    it "returns 0 if `git status` does not contain a line about commits ahead of a remote branch." do
      stub_command :status, :ahead_by_0
      git.ahead.should == 0
    end
  end

  describe 'clean?' do
    it 'returns true if `git status` contains: nothing to commit' do
      stub_command :status, :status_clean
      git.clean?.should be_true
    end

    it 'returns false if `git status` does not contain: nothing to commit' do
      stub_command :status, :status_dirty
      git.clean?.should be_false
    end
  end
end
