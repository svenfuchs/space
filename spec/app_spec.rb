# encoding: utf-8

require 'spec_helper'

describe Space::App do
  APP_COMMANDS = {
    'bundle config'              => "Settings are listed in order of priority. The top value will be used.\n",
    'bundle check'               => "The Gemfile's dependencies are satisfied",
    'bundle list'                => "  * travis-core (0.0.1 123456)",
    'git status'                 => "nothing to commit (working directory clean)",
    'git branch --no-color'      => "  feature\n* master\n",
    'git log -1 --no-color HEAD' => "commit ce8fb952efdd29371ebdc",
  }

  let(:app)    { Space::App.new('travis') }
  let(:config) { Space::Config.new(base_dir: '~/Development/projects/travis', repositories: %w(travis-ci travis-core)) }

  before :each do
    Space::Config.stubs(:load).returns(config)
    stub_commands
    app.stubs(:cli_loop)
  end

  def stub_commands
    APP_COMMANDS.each do |command, result|
      Space::Source::Command.stubs(:execute).with(command).returns(result)
    end
  end

  # describe 'running the app' do
  #   subject { strip_ansi(capture_stdout { app.run }) }

  #   it 'lists the repository' do
  #     should =~ /travis-ci:/
  #   end

  #   it 'displays the current branch' do
  #     should =~ /master/
  #   end

  #   it 'displays the current commit hash' do
  #     should =~ /ce8fb95/
  #   end

  #   it 'displays the git status' do
  #     should =~ /Git: ✔/
  #   end

  #   it 'displays the bundle status' do
  #     should =~ /Bundle: ✔/
  #   end

  #   it 'lists the dependencies' do
  #     should =~ /• 123456 ⚡ travis-core/
  #   end
  # end
end
