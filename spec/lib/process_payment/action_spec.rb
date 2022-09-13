require 'spec_helper'

RSpec.describe ProcessPayment::EntryPoint do
  let(:payment) { Payment.new(address_id: 1) }
  let(:address) { Address.new(uk: false) }
  let(:invoice) { Invoice.new(text: "text") }
  subject(:process_payment) { described_class.new(payment: payment) }

  include_context 'when stubbing dependencies for', PaymentsContainer

  before do
    expect(Invoice).to receive(:new).with(text: 'payment # to non-UK address').and_return(invoice)
    expect(injected_get_address).to receive(:call).and_return(address)
    expect(Command).to receive(:save).and_return(invoice)
  end

  it 'creates an invoice with the address' do
    expect(process_payment.call).to eql(invoice)
  end

  context "when FF support_hardcopy is turned on" do
    let(:address) { Address.new(uk: false) }
    let(:ff_support_hardcopy) { instance_double('FF', enabled?: true) }

    it 'sends a hardcopy invoice to non-UK customers' do
      # Arrange
      allow(Flipper).to receive(:[]).with('support_hardcopy').and_return(ff_support_hardcopy)

      # Act
      process_payment.call

      # Assert
      expect(injected_create_invoice_hardcopy).to have_received(:call)
    end
  end

  context "when FF support_hardcopy is turned off" do
    let(:address) { Address.new(uk: false) }
    let(:ff_support_hardcopy) { double(enabled?: false) }

    it 'sends a hardcopy invoice to non-UK customers' do
      expect(Flipper).to receive(:[]).with('support_hardcopy').and_return(ff_support_hardcopy)
      expect(injected_create_invoice_hardcopy).not_to receive(:call)
      process_payment.call
    end
  end
end
