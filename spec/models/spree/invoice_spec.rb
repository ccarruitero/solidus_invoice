# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:doc_number) }
    it { should validate_presence_of(:doc_type) }
  end
end
