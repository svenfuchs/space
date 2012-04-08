1.upto(100) do
  Thread.new do
    loop do
      p "KEKSE"
      sleep 1
    end
  end
end

sleep(100)
