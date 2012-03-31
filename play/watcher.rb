require 'rubygems'
$: << 'lib'

require 'space/watch'

Space::Watch.new(__FILE__) do |paths|
  p paths
end

Space::Watch.new('.') do |paths|
  p paths
end
sleep
