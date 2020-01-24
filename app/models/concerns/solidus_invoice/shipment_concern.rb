# frozen_string_literal: true

module SolidusInvoice
  module ShipmentConcern
    extend ActiveSupport::Concern

    def price_excluding_vat
      (amount - included_tax_total).round(2)
    end
  end
end
