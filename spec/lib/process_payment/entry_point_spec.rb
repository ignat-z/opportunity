# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ProcessPayment::EntryPoint do
  subject(:process_payment) { described_class.new(payment: payment) }

  let(:address) { create(:address, uk: false) }
  let(:payment) { create(:payment, address_id: address.id) }

  before { Flipper['support_hardcopy'].enable }

  it 'creates an invoice with the address' do
    result = nil
      expect { result = process_payment.call }.to change {
        InvoiceHardcopy.count
      }.from(0).to(1)

    expect(result.text).to eql(
      "payment ##{payment.id} to non-UK address"
    )
  end


  # context "when FF support_hardcopy is turned on" do
  #   let(:address) { create(:address, uk: false) }


  #   it 'sends a hardcopy invoice to non-UK customers' do

  #   end
  # end


  # context "when address is in UK" do
  #   let(:address) { create(:address, uk: true) }

  #   it 'sends a hardcopy invoice to UK customers' do
  #     expect { process_payment.call }.to change {
  #       InvoiceHardcopy.count
  #     }.from(0).to(1)
  #   end
  # end

  # context "when address isn't in UK" do
  #   let(:address) { create(:address, uk: false) }

  #   it "doesn't send a hardcopy invoice to UK customers" do
  #     count_before = InvoiceHardcopy.count
  #     process_payment.call
  #     count_after = InvoiceHardcopy.count
  #     expect(count_before).to eql(count_after)
  #   end
  # end

  # context "when FF support_hardcopy is turned off" do
  #   let(:address) { create(:address, uk: false) }
  #   before { Flipper['support_hardcopy'].disable }

  #   it "doesn't sends a hardcopy invoice to UK customers" do
  #     count_before = InvoiceHardcopy.count
  #     process_payment.call
  #     count_after = InvoiceHardcopy.count
  #     expect(count_before).to eql(count_after)
  #   end
  # end
end
