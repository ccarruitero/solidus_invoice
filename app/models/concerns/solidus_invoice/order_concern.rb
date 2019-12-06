# frozen_string_literal: true

require 'solidus_invoice/errors/invalid_serial_error'

module SolidusInvoice
  module OrderConcern
    extend ActiveSupport::Concern

    included do
      has_many :invoices
      after_save :generate_invoice

      def generate_invoice
        return unless can_generate_invoice?

        doc_type = bill_address.tax_uid ? '01' : '03'
        doc_number = next_correlative(doc_type)

        # generate Spree::Invoice
        invoices.create(doc_type: doc_type,
                        doc_number: doc_number,
                        order: self)
      end

      def can_generate_invoice?
        completed? && paid?
      end

      # given a store and document type get next posible correlative
      def next_correlative(doc_type, store_id = Spree::Store.default.id)
        store = Spree::Store.includes(invoice_serials: :invoices).find(store_id)
        serial = store.invoice_serials.find_by(doc_type: doc_type)
        raise SolidusInvoice::InvalidSerialError unless serial

        current = serial&.invoices&.order(doc_number: :desc)&.first&.doc_number || 0
        current + 1
      end
    end
  end
end
