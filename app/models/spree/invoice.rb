# frozen_string_literal: true

require 'sunat_invoice'

class Spree::Invoice < Spree::Base
  validates :doc_number, presence: true

  belongs_to :order
  belongs_to :invoice_serial

  delegate :doc_type, :serial, to: :invoice_serial

  preference :sunat_attributes, :hash

  def sunat_attributes
    attrs = (preferred_sunat_attributes || {}).dup
    provider = SunatInvoice::Provider.new(attrs[:provider] || {})
    attrs[:provider] = provider
    attrs
  end

  # return a `SunatInvoice::Invoice`
  def build_sunat_invoice
    # generate SunatInvoice::Invoice
    sunat_invoice = SunatInvoice::Invoice.new(sunat_attributes)

    # add invoice lines from line_items
    order.line_items.map do |line_item|
      add_sunat_line(sunat_invoice, line_item)
    end

    # add invoice lines from shipment
    order.shipments.map do |shipment|
      next unless shipment.amount.positive?

      add_sunat_line(sunat_invoice, shipment)
    end

    # store xml
    store_xml(sunat_invoice.xml) if respond_to?(:store_xml)

    sunat_invoice
  end

  # add a new `SunatInvoice::Item` to the given sunat invoice
  # sunat_invoice => `SunatInvoice::Invoice` instance to add lines
  # resource => an order's line_item or shipment
  def add_sunat_line(sunat_invoice, resource)
    # TODO: handle items with taxes different than vat
    tax_amount = resource.adjustments.tax.sum(:amount)
    tax = SunatInvoice::Tax.new(amount: tax_amount, tax_type: :igv)
    quantity = resource.respond_to?(:quantity) ? resource.quantity : 1
    item_attrs = {
      quantity: quantity,
      price: resource.price_excluding_vat,
      price_code: '01',
      taxes: [tax]
    }
    sunat_invoice.lines << SunatInvoice::Item.new(item_attrs)
  end
end
