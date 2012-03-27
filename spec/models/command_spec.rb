require 'spec_helper'

describe Command do
  describe 'result' do
    it 'changes to the path'
    it 'calls the command'
    it 'removes ansi codes'
  end

  describe 'strip_ansi' do
    it 'removes \e[34m'
    it 'removes \e[0m'
  end
end

