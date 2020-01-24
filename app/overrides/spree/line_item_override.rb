# frozen_string_literal: true

module Spree::LineItemOverride
  Spree::LineItem.include SolidusInvoice::LineItemConcern
end
