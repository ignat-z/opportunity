class Command
  class << self
    def save(record)
      sleep(THROTTLING)
      record.tap(&:save!)
    end
  end
end
