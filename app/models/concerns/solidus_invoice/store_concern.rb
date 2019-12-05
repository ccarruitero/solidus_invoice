# frozen_string_literal: true

module SolidusInvoice
  module StoreConcern
    extend ActiveSupport::Concern

    included do
      has_many :invoice_serials
    end
  end
end
