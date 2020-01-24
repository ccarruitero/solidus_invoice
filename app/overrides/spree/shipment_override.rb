# frozen_string_literal: true

module Spree::ShipmentOverride
  Spree::Shipment.include SolidusInvoice::ShipmentConcern
end
