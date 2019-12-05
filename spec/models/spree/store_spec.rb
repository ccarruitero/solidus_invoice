# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Store, type: :model do
  describe 'associations' do
    it { should have_many(:invoice_serials) }
  end
end
