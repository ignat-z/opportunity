require 'spec_helper'

RSpec.describe ProcessPayment::EntryPoint do
  subject { described_class.new(payment: payment) }

  let(:address) { create(:address, uk: true) }
  let(:payment) { create(:payment, address_id: address.id) }

  it "creates a receipt with the address" do
    expect(subject.call.text).to eql(
      "payment ##{payment.id} to UK address"
    )
  end
end
