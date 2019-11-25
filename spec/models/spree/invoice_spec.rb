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
end
