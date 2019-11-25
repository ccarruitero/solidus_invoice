# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Order, type: :model do
  describe 'associations' do
    it { should have_many(:invoices) }
  end

  describe 'next_correlative' do
    xit 'sum 1 to last correlative' do
    end
  end

  describe 'generate_invoice' do
    context 'with valid params' do
      xit 'generate Spree::Invoice' do
      end
    end
  end
end
