# frozen_string_literal: true

require './lib/command'
require './lib/entry_point'

require './lib/payments_container'

require './lib/create_invoice_hardcopy/action'
require './lib/create_invoice_hardcopy/entry_point'

require './lib/get_address/action'
require './lib/get_address/entry_point'

require './lib/process_payment/entry_point'
require './lib/process_payment/action'

THROTTLING = 0.1
$memory = {}

class MyAr
  def self.find(id)
    sleep(THROTTLING)
    $memory["#{name.downcase}_#{id}"]
  end

  def self.count
    $memory.keys.count { _1.include?(name.downcase) }
  end

  attr_accessor :id

  def save!
    sleep(THROTTLING)
    self.id ||= rand(2048)
    $memory["#{self.class.name.downcase}_#{id}"] = self
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
    $ffs ||= { 'support_hardcopy' => Record.new }
    $ffs.fetch(attr)
  end
end

class InvoiceHardcopy < MyAr
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
    @uk ? 'UK' : 'non-UK'
  end
end
