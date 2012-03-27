require 'spec_helper'

describe Git do
  describe 'clean?' do
    it 'returns true if `git status -s` is empty'
    it 'returns false if `git status -s` is not empty'
  end

  describe 'branch' do
    it 'returns the current branch name from `git branch --no-color`'
  end

  describe 'commit' do
    it 'it returns the commit hash from `git log -1 head`'
  end
end

