# frozen_string_literal: true

FactoryBot.define do
  factory :invoice, class: 'Spree::Invoice' do
    doc_number { rand(450) }
    order { order_ready_to_ship }
    invoice_serial
  end

  factory :invoice_serial, class: 'Spree::Invoice' do
    store
    doc_type { '03' }
    serial { 'B023' }
  end
end
