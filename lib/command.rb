class Command
  class << self
    def save(record)
      record.tap(&:save!)
    end
  end
end
