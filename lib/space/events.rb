module Space
  module Events
    def observers
      @observers ||= []
    end

    def subscribe(observer)
      observers << observer
    end

    def notify(event, data)
      puts "EVENT #{event.inspect} #{self.class} => #{observers.map(&:class).inspect}"
      observers.each { |observer| observer.notify(event, data) }
    end
  end
end
