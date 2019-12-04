# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusInvoice::DailySummaryJob, type: :job do
  let(:invoice) { factory(:invoice) }
  let(:subject) {
    described_class.perform_later(
      doc_type: invoice.invoice_serial.serial,
      store_id: invoice.order.store.id
    )
  }

  it 'generate summary lines by each invoice' do
  end

  it 'generate correct daily summary document' do
  end

  describe '#send_sunat' do
    it 'call summary client' do
    end
  end
end
