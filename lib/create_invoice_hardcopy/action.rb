module CreateInvoiceHardcopy
  class Action
    def initialize(invoice:)
      @invoice = invoice
    end

    def call
      Command.save(InvoiceHardcopy.new)
    end
  end
end
