require 'spec_helper'

describe Repos do
  let(:config) { Hashr.new(:paths => paths) }
  let(:paths)  { %w(/path/to/foo /path/to/bar /path/to/baz) }

  before :each do
    App.stubs(:config).returns(config)
  end

  describe 'class methods' do
    it 'all returns a collection of all repos as defined in the config' do
      Repos.all.map(&:path).should == config.paths
    end

    it 'select returns a collection scoped to the given names' do
      Repos.select(%w(foo bar)).names.should == %w(foo bar)
    end

    it 'find_by_name finds the repository by name' do
      Repos.find_by_name('foo').name.should == 'foo'
    end
  end

  describe 'instance methods' do
    it 'names returns the names of the contained repositories' do
      Repos.all.names.should == %w(foo bar baz)
    end
  end
end

