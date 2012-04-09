require 'open3'

dirs = %w(travis-pro-ci travis-pro-hub travis-pro-listener travis-pro-core travis-ci travis-hub travis-listener travis-core travis-support)
base_dir = '~/Development/projects/travis'

1.times do
  dirs.each do |dir|
    Thread.new do
      result = nil
      pid = fork do
        Dir.chdir(File.expand_path(dir, base_dir)) do
          result = `pwd`
          p result
        end
      end
      Process.waitpid(pid)
      p result
    end
  end
end

sleep
