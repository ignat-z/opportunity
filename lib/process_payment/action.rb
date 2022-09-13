# frozen_string_literal: true

module ProcessPayment
  class Action
    include ::PaymentsDependencies[
      'get_address',
      'create_invoice_hardcopy'
    ]

    def initialize(payment:, **deps)
      super(**deps)

      @payment = payment
    end

    def call
      address = get_address.call(payment: @payment)
      invoice = Invoice.new(attributes(address))

      Command.save(invoice).tap do
        create_invoice_hardcopy.call(invoice: _1) if address.in_uk? || Flipper['support_hardcopy'].enabled?
      end
    end

    private

    def attributes(address)
      { text: "payment ##{@payment.id} to #{address.text} address" }
    end
  end
end
