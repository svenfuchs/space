require 'spec_helper'

describe Repo do
  describe 'name' do
    it 'returns the basename of the repository directory' do
    end
  end

  describe 'ref' do
    it 'returns the git commit' do

    end
  end

  describe 'current?' do
    it 'returns true when the app scope is the current repo'
    it 'returns false when the app scope is not the current repo'
  end

  describe 'dependent_repos' do
    it 'returns repos that this repo depends on'
  end

  describe 'reset' do
    it 'resets its git'
    it 'resets its bundle'
  end

  describe 'execute' do
    it 'changes to the repository directory'
    it 'runds the given command'
  end
end

