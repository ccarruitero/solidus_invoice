# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusInvoice::InvoiceJob, type: :job do
  let(:store) { create(:store) }
  let(:address) { create(:address, tax_uid: '10800286726') }
  let(:cli) { class_double('SunatInvoice::InvoiceClient') }

  context 'with doc_type 01' do
    let(:order) { create(:order_ready_to_ship, store: store, bill_address: address) }
    let!(:invoice_serial) { create(:invoice_serial, store: store, doc_type: '01') }
    let(:provider) { build(:provider) }
    let(:invoice) {
      create(:invoice, invoice_serial: invoice_serial, order: order,
             preferred_sunat_attributes: {
               provider: provider.to_hash
             })
    }
    let(:subject) {
      described_class.perform_now(
        doc_type: invoice.invoice_serial.doc_type,
        store_id: invoice.order.store.id,
        invoice_id: invoice.id,
        env: 'dev'
      )
    }

    before do
      SunatInvoice.configure do |c|
        c.account_ruc = provider.ruc
        c.account_user = 'MODDATOS'
        c.account_password = 'moddatos'
      end
    end

    def http_response(options = {})
      # savon success response
      defaults = { code: 200, headers: {}, body: {} }
      response = defaults.merge options

      http = HTTPI::Response.new response[:code], response[:headers], response[:body]
      Savon::Response.new(http, {}, {})
    end

    it 'update invoice attribute' do
      allow_any_instance_of(SunatInvoice::InvoiceClient).to receive(:dispatch)
        .and_return(http_response)
      subject
      invoice.reload
      expect(invoice.communicated).to eq(true)
    end
  end

  context 'with doc_type 03' do
    let(:order) { create(:order_ready_to_ship, store: store) }
    let!(:invoice_serial) { create(:invoice_serial, store: store) }
    let(:boleta) { create(:invoice, invoice_serial: invoice_serial, order: order) }
    let(:subject) {
      described_class.perform_later(
        doc_type: boleta.invoice_serial.doc_type,
        store_id: boleta.order.store.id,
        invoice_id: boleta.id
      )
    }
    it 'dont update invoice attribute' do
      expect(boleta.communicated).to eq(false)
    end
  end

  xit 'generate new invoice in SUNAT' do
    expect(sunat_invoice.dispatch.called).once
  end
end
