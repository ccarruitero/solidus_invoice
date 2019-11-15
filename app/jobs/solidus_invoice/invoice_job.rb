# frozen_string_literal: true

class SolidusInvoice::InvoiceJob < ApplicationJob
  queue_as :default

  def perform(*args)
    invoice = Spree::Invoice.find(args[:invoice_id])

    if invoice.doc_type == '01'
      # generate Sunat::Invoice
      sunat_invoice = SunatInvoice::Invoice.new(invoice.sunat_attributes)

      # send to sunat
      client = SunatInvoice::InvoiceClient.new
      client.dispatch(sunat_invoice)
    end
  end
end
