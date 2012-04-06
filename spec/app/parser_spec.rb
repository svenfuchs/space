require 'spec_helper'

describe Space::App::Parser do
  let(:names) { %w(travis-ci travis-core) }
  let(:parser) { Space::App::Parser.new(names) }

  describe 'parse' do
    results = {
      'travis-ci'                    => [['travis-ci'],                nil],
      'travis-ci travis-core'        => [['travis-ci', 'travis-core'], nil],
      '1'                            => [['travis-ci'],                nil],
      '1 2'                          => [['travis-ci', 'travis-core'], nil],
      'travis-ci reload'             => [['travis-ci'],                'reload'],
      'travis-ci travis-core reload' => [['travis-ci', 'travis-core'], 'reload'],
      '1 reload'                     => [['travis-ci'],                'reload'],
      '1 2 reload'                   => [['travis-ci', 'travis-core'], 'reload'],
    }

    results.each do |line, result|
      it "returns #{result.inspect} for #{line.inspect}" do
        parser.parse(line.dup).should == result
      end
    end
  end
end

