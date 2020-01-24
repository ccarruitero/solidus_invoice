# frozen_string_literal: true

module SolidusInvoice
  module LineItemConcern
    extend ActiveSupport::Concern

    def price_excluding_vat
      (price - (included_tax_total / quantity)).round(2)
    end
  end
end
