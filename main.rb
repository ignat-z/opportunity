require './lib/command'
require './lib/entry_point'

require './lib/payments_container'

require './lib/get_address/action'
require './lib/get_address/entry_point'

require './lib/process_payment/entry_point'
require './lib/process_payment/action'

THROTTLING = 0.1
$memory = {}

class MyAr
  def self.find(id)
    sleep(THROTTLING)
    $memory["#{self.name.downcase}_#{id}"]
  end

  attr_accessor :id

  def save!
    true
  end
end

module Flipper
  class Record
    def initialize(on = false)
      @on = on
    end

    def enabled?
      @on
    end

    def enable
      @on = true
    end

    def disable
      @on = false
    end
  end

  def self.[](attr)
    $ffs ||= { 'extra_payments' => Record.new }
    $ffs.fetch(attr)
  end
end

class Invoice < MyAr
  def initialize(attributes)
    @text = attributes.fetch(:text)
  end

  attr_reader :text
end

class Payment < MyAr
  def initialize(address_id:)
    @address_id = address_id
  end

  attr_reader :address_id
end

class Address < MyAr
  def initialize(uk:)
    @uk = uk
  end

  def in_uk?
    @uk
  end

  def text
    @uk ? "UK" : "non-UK"
  end
end
