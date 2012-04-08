require 'rubygems'
require 'rb-fsevent'

path = File.expand_path('.')

Thread.new do
  begin
    fsevent = FSEvent.new
    fsevent.watch(path, latency: 0.1, file: File.file?(path)) do |paths|
      p '-------------'
      p paths
    end
    fsevent.run
  rescue => e
    puts e.message
  end
end

sleep
