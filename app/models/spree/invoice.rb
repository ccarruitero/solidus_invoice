# frozen_string_literal: true

class Spree::Invoice < Spree::Base
  validates :doc_number, presence: true

  belongs_to :order
  belongs_to :invoice_serial

  def sunat_attributes; end
end
