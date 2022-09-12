module ProcessPayment
  class Action
    include ::PaymentsDependencies['get_address']

    def initialize(payment:, **deps)
      super(**deps)

      @payment = payment
    end

    def call
      address = get_address.call(payment: @payment)
      invoice = Invoice.new(attributes(address))
      Command.save(invoice)
    end

    private

    def attributes(address)
      { text: "payment ##{@payment.id} to #{address.text} address" }
    end
  end
end
