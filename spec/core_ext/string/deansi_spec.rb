require 'core_ext/string/deansi'

describe 'String#deansi' do
  it 'removes ansi codes from the string' do
    string = 'foo'.ansi(:green, :bold)
    string.deansi.should == 'foo'
  end
end
