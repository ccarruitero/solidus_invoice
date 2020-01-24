# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:doc_number) }
  end

  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:invoice_serial) }
  end

  context 'sunat invoice' do
    let(:invoice) { create(:invoice_with_serial) }
    let(:order) { create(:order_ready_to_ship, store: invoice.invoice_serial.store) }

    before do
      invoice.update(order: order)
    end

    describe '#build_sunat_invoice' do
      subject(:sunat_invoice) { invoice.build_sunat_invoice }

      it 'return a sunat invoice instance' do
        expect(sunat_invoice.class).to eq(SunatInvoice::Invoice)
      end

      it 'get same total than order' do
        sunat_invoice.prepare_totals
        expect(invoice.order.total).to eq(sunat_invoice.total.to_d)
      end
    end

    describe '#add_sunat_line' do
      let(:sunat_invoice) { SunatInvoice::Invoice.new(invoice.sunat_attributes) }
      let(:line) { order.line_items.first }

      before do
        invoice.add_sunat_line(sunat_invoice, line)
      end

      it 'add line to sunat invoice' do
        expect(sunat_invoice.lines.count).to eq(1)
      end

      it 'has correct values' do
        sunat_line = sunat_invoice.lines.first
        expect(sunat_line.quantity).to eq(line.quantity)
        expect(sunat_line.price).to eq(line.price_excluding_vat)
      end
    end
  end
end
