# frozen_string_literal: true

module GetAddress
  class EntryPoint
    include ::EntryPoint

    def initialize(payment:)
      @payment = payment
      @action = GetAddress::Action.new(payment: @payment)
    end
  end
end
