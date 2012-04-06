module Space
  module Events
    def observers
      @observers ||= []
    end

    def subscribe(observer)
      observers << observer
    end

    def notify(event, data)
      observers.each { |observer| observer.notify(event, data) }
    end
  end
end
