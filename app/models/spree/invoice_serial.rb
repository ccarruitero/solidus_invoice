# frozen_string_literal: true

class Spree::InvoiceSerial < Spree::Base
  validates :serial, presence: true, uniqueness: { scope: :store_id }
  validates :store_id, presence: true

  belongs_to :store
  has_many :invoices
end
