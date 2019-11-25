# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::InvoiceSerial, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:serial) }
    it { should validate_presence_of(:store_id) }
  end

  describe 'associations' do
    it { should belong_to(:store) }
    it { should have_many(:invoices) }
  end
end
