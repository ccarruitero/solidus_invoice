# frozen_string_literal: true

FactoryBot.define do
  factory :invoice, class: 'Spree::Invoice' do
    doc_number { rand(450) }
    order
    invoice_serial

    factory :invoice_with_serial do
      before(:create) do |invoice|
        store = create(:store)
        invoice.invoice_serial { create(:invoice_serial, store: store) }
      end
    end
  end

  factory :invoice_serial, class: 'Spree::InvoiceSerial' do
    store
    doc_type { '03' }
    serial { 'B023' }
  end

  factory :provider, class: 'SunatInvoice::Provider' do
    signature_id { 'signatureST' }
    signature_location_id { 'signQWI3' }
    ruc { '20100454523' }
    name { 'MY BUSINESS' }
  end

  factory :customer, class: 'SunatInvoice::Customer' do
    ruc { '20293028401' }
    name { 'SOME BUSINESS' }
  end
end
