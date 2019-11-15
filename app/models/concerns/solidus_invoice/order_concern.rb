# frozen_string_literal: true

module SolidusInvoice
  module OrderConcern
    included do
      has_many :invoices
      after_save :generate_invoice

      private

      def generate_invoice
        return unless can_generate_invoice?

        doc_type = bill_address.uid ? '01' : '03'
        doc_number = next_correlative(doc_type)
        # generate Spree::Invoice
        invoice = invoices.create(doc_type: doc_type,
                                  doc_number: doc_number,
                                  order: self)
        SolidusInvoice::SunatJob.perform_later(invoice.id)
      end

      def can_generate_invoice?
        completed?
      end

      def next_correlative(doc_type, store_id)
        store = Spree::Store.where(store_id: store_id)
        serial = store.invoice_serials.includes(:invoices).find(doc_type: doc_type)
        number = serial.invoices.order(correlative: :desc).first.correlative + 1
        "#{serial}-#{number}"
      end
    end
  end
end
