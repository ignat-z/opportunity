module EntryPoint
  def self.included(base)
    base.extend ClassMethods
  end

  def call
    @action.call
  end

  module ClassMethods
    def call(...)
      new(...).call
    end
  end
end
