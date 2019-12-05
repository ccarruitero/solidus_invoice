# frozen_string_literal: true

module Spree::StoreOverride
  Spree::Store.include SolidusInvoice::StoreConcern
end
