require 'spec_helper'

describe Space::Models::Repo do
  let(:project) { stub('project', repos: stub('repos')) }
  let(:repo)    { Space::Models::Repo.new(project, './travis-ci') }

  describe 'name' do
    it 'returns the basename of its directory' do
      repo.name.should == 'travis-ci'
    end
  end
end

