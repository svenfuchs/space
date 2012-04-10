require 'core_ext/enumerable/map_slice'

describe 'Enumerable#map_slice' do
  it 'maps each slice of the given size' do
    actual   = [1, 2, 3, 4, 5, 6].map_slice(3) { |a| a }
    expected = [[1, 2, 3], [4, 5, 6]]
    actual.should == expected
  end
end
