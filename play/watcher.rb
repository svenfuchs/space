require 'rubygems'
$: << 'lib'

require 'space/watch'

watch = Space::Watch.new(__FILE__) do |paths|
  p paths
end
watch.run

# Space::Watch.new('.') do |paths|
#   p paths
# end
sleep
