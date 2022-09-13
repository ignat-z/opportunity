# frozen_string_literal: true

module ProcessPayment
  class EntryPoint
    include ::EntryPoint

    def initialize(payment:)
      @payment = payment
      @action = ProcessPayment::Action.new(payment: @payment)
    end
  end
end
