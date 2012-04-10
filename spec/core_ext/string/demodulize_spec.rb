require 'core_ext/string/demodulize'

describe 'String#demodulize' do
  it 'demodulizes the string' do
    string = 'Foo::Bar::Baz'
    string.demodulize.should == 'Baz'
  end
end
