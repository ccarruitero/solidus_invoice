# frozen_string_literal: true

require 'sunat_invoice'

class Spree::Invoice < Spree::Base
  validates :doc_number, presence: true

  belongs_to :order
  belongs_to :invoice_serial

  delegate :doc_type, to: :invoice_serial

  preference :sunat_attributes, :hash

  def sunat_attributes
    attrs = (preferred_sunat_attributes || {}).dup
    provider = SunatInvoice::Provider.new(attrs[:provider])
    attrs[:provider] = provider
    attrs
  end
end
