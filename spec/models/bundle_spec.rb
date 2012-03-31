require 'spec_helper'

describe Bundle do
  let(:app)    { stub('app', :name => 'travis') }
  let(:repo)   { stub('repo', :name => 'travis-ci') }
  let(:repos)  { stub('repos') }
  let(:bundle) { Bundle.new('travis', repos, 'path/to/repo') }

  before :each do
    app.stubs(:repos).returns([repo])
    App.stubs(:name).returns('travis')
  end

  describe 'clean?' do
    it 'returns true if info includes "dependencies are satisfied"' do
      bundle.stubs(:info).returns("The Gemfile's dependencies are satisfied")
      bundle.clean?.should be_true
    end

    it 'returns false if info does not include "dependencies are satisfied"' do
      bundle.stubs(:info).returns("Your Gemfile's dependencies could not be satisfied")
      bundle.clean?.should be_false
    end
  end

  describe 'info' do
    it 'returns the first line from `bundle check`' do
      bundle.stubs(:result).with(:check).returns("first line\nsecond line")
      bundle.info.should == 'first line'
    end
  end

  describe 'deps' do
    it 'returns dependencies listend in `bundle list` that match the app name' do
      bundle.stubs(:result).with(:list, :name => 'travis').returns("  * travis-ci (0.0.1 123456)")
      dep = bundle.deps.first
      [dep.name, dep.ref].should == ['travis-ci', '123456']
    end
  end

  describe 'local_repos' do
    it 'returns local repositories as defined in the bundle config' do
      bundle.stubs(:config).returns('foo' => 'bar', 'local.travis-core' => 'path/to/travis-core')
      bundle.local_repos.first.should == 'travis-core'
    end
  end

  describe 'config' do
    it 'returns a hash of config key value pairs as defined in `bundle config``' do
      bundle.stubs(:result).with(:config).returns("Settings are listed in order of priority. The top value will be used.\n\nlocal.travis-core\nSet for the current user (path/to/config): \"path/to/travis-core\"")
      bundle.config.should == { 'local.travis-core' => 'path/to/travis-core' }
    end
  end
end

