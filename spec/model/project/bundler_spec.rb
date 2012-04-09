require 'spec_helper'

describe Space::Model::Project::Bundler do
  BUNDLER_RESULTS = {
    :config => <<-config
Settings are listed in order of priority. The top value will be used.

without
  Set for the current user (/Volumes/Users/sven/.bundle/config): ""

local_override_require_branch
  Set for the current user (/Volumes/Users/sven/.bundle/config): "false"
config
  }

  let(:project) { stub('project') }
  let(:bundler) { Space::Model::Project::Bundler.new(project) }

  def stub_command(command, result = command)
    bundler.stubs(:result).with(command).returns BUNDLER_RESULTS[result].dup
  end

  describe 'config' do
    it 'returns the global bundler config as a hash' do
      stub_command :config
      bundler.config['local_override_require_branch'].should == 'false'
    end
  end
end



