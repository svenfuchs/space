require 'core_ext/string/wrap'

describe 'String#wrap' do
  it 'wraps the string at the given column' do
    string = 'a' * 20
    string.wrap(5).should == "aaaaa\naaaaa\naaaaa\naaaaa"
  end
end
