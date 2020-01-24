# frozen_string_literal: true

require 'sunat_invoice'

class SolidusInvoice::InvoiceJob < ApplicationJob
  queue_as :default

  def perform(*args)
    opts = args[0]
    invoice = Spree::Invoice.find(opts[:invoice_id])
    env = opts[:env]

    sunat_invoice = invoice.build_sunat_invoice

    if invoice.doc_type == '01'
      # send to SUNAT
      client = SunatInvoice::InvoiceClient.new(env)
      response = client.dispatch(sunat_invoice)
      invoice.update(communicated: true) if response.success?
    end
  end
end
