# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Shipment, type: :model do
  describe 'price_excluding_vat' do
    let(:tax_price) { ((100 / 1.18) * 0.18).round(2) }
    let(:without_vat) { (100 - tax_price).round(2) }

    context 'with one unit' do
      let(:shipment) { create(:shipment, included_tax_total: tax_price) }

      it 'should return correct calculation' do
        expect(shipment.price_excluding_vat).to eq(without_vat.to_d)
      end
    end

    context 'without included_tax' do
      let(:shipment) { create(:shipment) }

      it 'should return correct calculation' do
        expect(shipment.price_excluding_vat).to eq(shipment.cost)
      end
    end
  end
end
