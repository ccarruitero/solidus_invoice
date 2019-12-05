# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Address, type: :model do
  let(:subject) { described_class.new }

  it 'have tax_uid field' do
    expect(subject.respond_to?(:tax_uid)).to eq(true)
  end
end
