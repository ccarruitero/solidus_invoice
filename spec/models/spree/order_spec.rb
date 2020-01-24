# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Order, type: :model do
  let(:store) { create(:store) }
  let!(:order) { create(:order, store: store) }
  let!(:invoice_serial) { create(:invoice_serial, store: store) }

  describe 'associations' do
    it { should have_many(:invoices) }
  end

  describe 'next_correlative' do
    it 'sum 1 to last correlative' do
      expect(store.invoice_serials.first.invoices.count).to eq(0)
      expect(order.next_correlative('03')).to eq(1)
    end

    it 'raise error when dont have serials for doc_type' do
      expect { order.next_correlative('01') }.to raise_error(SolidusInvoice::InvalidSerialError)
    end
  end

  describe 'generate_invoice' do
    context 'with valid params' do
      xit 'generate Spree::Invoice' do
      end
    end
  end
end
