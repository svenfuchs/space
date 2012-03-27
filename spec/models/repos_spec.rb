require 'spec_helper'

describe Repos do
  describe 'scoped' do
    it 'returns all repositories when the app does not have a scope'
    it 'returns the current app scope repository and all of its dependent repos'
  end

  describe 'all' do
    it 'returns all repositories for paths defined in the config'
  end

  describe 'find_by_name' do
    it 'finds the repo by its name'
  end
end

