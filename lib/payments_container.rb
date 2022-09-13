# frozen_string_literal: true

require 'dry-auto_inject'

class PaymentsContainer
  extend Dry::Container::Mixin

  register 'get_address' do
    ::GetAddress::EntryPoint
  end

  register 'process_payment' do
    ::ProcessPayment::EntryPoint
  end

  register 'create_invoice_hardcopy' do
    ::CreateInvoiceHardcopy::EntryPoint
  end
end

PaymentsDependencies = Dry::AutoInject(PaymentsContainer)
