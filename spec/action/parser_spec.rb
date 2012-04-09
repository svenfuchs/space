require 'spec_helper'

describe Space::Action::Parser do
  let(:names) { %w(travis-ci travis-core) }
  let(:parser) { Space::Action::Parser.new(names) }

  describe 'parse' do
    results = {
      'travis-ci'                    => [['travis-ci'],                nil],
      'travis-ci travis-core'        => [['travis-ci', 'travis-core'], nil],
      '1'                            => [['1'],                        nil],
      '1 2'                          => [['1', '2'],                   nil],
      'travis-ci reload'             => [['travis-ci'],                'reload'],
      'travis-ci travis-core reload' => [['travis-ci', 'travis-core'], 'reload'],
      '1 reload'                     => [['1'],                        'reload'],
      '1 2 reload'                   => [['1', '2'],                   'reload'],
    }

    results.each do |line, result|
      it "returns #{result.inspect} for #{line.inspect}" do
        parser.parse(line.dup).should == result
      end
    end
  end
end

