# frozen_string_literal: true

class Spree::InvoiceSerial < Spree::Base
  validates :serial, presence: true
  validates :store_id, presence: true

  belongs_to :store
  has_many :invoices
end
