require 'spec_helper'

describe Dependency do
  describe 'fresh?' do
    it 'returns true if the (locked) dep ref is the actual current repository ref'
    it 'returns false if the (locked) dep ref differs from the actual current repository ref'
  end

  describe 'repo' do
    it 'it returns the repository this dependency refers to'
  end
end

