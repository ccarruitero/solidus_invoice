# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::LineItem, type: :model do
  describe 'price_excluding_vat' do
    let(:tax_price) { ((10 / 1.18) * 0.18).round(2) }
    let(:without_vat) { (10 - tax_price).round(2) }

    context 'with one unit' do
      let(:line_item) { create(:line_item, included_tax_total: tax_price) }

      it 'should return correct calculation' do
        expect(line_item.price_excluding_vat).to eq(without_vat.to_d)
      end
    end

    context 'with more than one unit' do
      let(:tax_total) { (tax_price * 3).round(2) }
      let(:line_item) {
        create(:line_item, included_tax_total: tax_total, quantity: 3)
      }

      it 'should return correct calculation' do
        expect(line_item.price_excluding_vat).to eq(without_vat.to_d)
      end
    end

    context 'without included_tax' do
      let(:line_item) { create(:line_item) }

      it 'should return correct calculation' do
        expect(line_item.price_excluding_vat).to eq(line_item.price)
      end
    end
  end
end
