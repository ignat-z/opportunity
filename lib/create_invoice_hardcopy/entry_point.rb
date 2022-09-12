module CreateInvoiceHardcopy
  class EntryPoint
    include ::EntryPoint

    def initialize(invoice:)
      @invoice = invoice
      @action = CreateInvoiceHardcopy::Action.new(invoice: @invoice)
    end
  end
end
