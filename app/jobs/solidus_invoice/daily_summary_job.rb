# frozen_string_literal: true

class SolidusInvoice::DailySummaryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # find all doc_type doc without comunication
    serials = Spree::InvoiceSerial.includes(:invoices).where(
      doc_type: args[:doc_type],
      store_id: args[:store_id]
    )

    lines = []

    serials.each do
      invoices = serials.invoices.where(communicated: false).order(doc_number: :asc)
      line = SunatInvoice::SummaryLine.new(document_type: serial.doc_type,
                                           document_serial: serial.serial,
                                           start_document_number: invoice.first.doc_number,
                                           end_document_number: invoice.last.doc_number,
                                           total_amount: invoices.sum(:total),
                                           taxable: invoice.sum(:taxable))
      lines << line
    end

    # send to sunat
    client = SunatInvoice::InvoiceClient.new
    summary = SunatInvoice::DailySummary.new(reference_date: Time.with_zone.yesterday,
                                             lines: lines)
    client.dispatch(summary)
  end
end
