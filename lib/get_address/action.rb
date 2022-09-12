module GetAddress
  class Action
    def initialize(payment:)
      @payment = payment
    end

    def call
      Address.find(@payment.address_id)
    end
  end
end
