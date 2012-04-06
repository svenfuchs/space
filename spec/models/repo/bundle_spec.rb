require 'spec_helper'

describe Space::Models::Repo::Bundle do
  BUNDLE_RESULTS = {
    check_clean: %(The Gemfile's dependencies are satisfied),
    check_dirty: %(Your Gemfile's dependencies could not be satisfied),
    list:        %(  * travis-ci (0.0.1 123456))
  }

  let(:repo)    { stub('repo', path: '.') }
  let(:repos)   { stub('repos', names: %w(travis-ci), find_by_name: repo) }
  let(:bundle)  { Space::Models::Repo::Bundle.new(repo, repos) }

  def stub_command(command, result = command)
    bundle.commands[command].stubs(:result).returns BUNDLE_RESULTS[result].dup
  end

  describe 'clean?' do
    it 'returns true if info includes "dependencies are satisfied"' do
      stub_command :check, :check_clean
      bundle.clean?.should be_true
    end

    it 'returns false if info does not include "dependencies are satisfied"' do
      stub_command :check, :check_dirty
      bundle.clean?.should be_false
    end
  end

  describe 'info' do
    it 'returns the first line from `bundle check`' do
      stub_command :check, :check_clean
      bundle.info.should == BUNDLE_RESULTS[:check_clean]
    end
  end

  describe 'deps' do
    it 'returns dependencies listend in `bundle list` that match the app name' do
      stub_command :list
      dep = bundle.deps.first
      [dep.repo, dep.ref].should == [repo, '123456']
    end
  end
end


