require 'open3'

dirs = %w(travis-pro-ci travis-pro-hub travis-pro-listener travis-pro-core travis-ci travis-hub travis-listener travis-core travis-support)
base_dir = '~/Development/projects/travis'

10.times do
  dirs.each do |dir|
    Thread.new do
      result, status = Open3.capture2("cd #{File.expand_path(dir, base_dir)} && pwd")
      p [dir, File.basename(result.chomp)]
    end
  end
end

sleep
