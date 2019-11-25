# frozen_string_literal: true

module Spree::OrderOverride
  Spree::Order.include SolidusInvoice::OrderConcern
end
