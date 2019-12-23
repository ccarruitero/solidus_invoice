# frozen_string_literal: true

require 'sunat_invoice'

class SolidusInvoice::InvoiceJob < ApplicationJob
  queue_as :default

  def perform(*args)
    opts = args[0]
    invoice = Spree::Invoice.find(opts[:invoice_id])
    env = opts[:env]

    if invoice.doc_type == '01'
      # generate SunatInvoice::Invoice
      sunat_invoice = SunatInvoice::Invoice.new(invoice.sunat_attributes)

      # send to SUNAT
      client = SunatInvoice::InvoiceClient.new(env)
      response = client.dispatch(sunat_invoice)
      invoice.update(communicated: true) if response.success?
    end
  end
end
