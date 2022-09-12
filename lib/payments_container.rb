require 'dry-auto_inject'

class PaymentsContainer
  extend Dry::Container::Mixin

  register "get_address" do
    ::GetAddress::EntryPoint
  end

  register "process_payment" do
    ::ProcessPayment::EntryPoint
  end
end

PaymentsDependencies = Dry::AutoInject(PaymentsContainer)
