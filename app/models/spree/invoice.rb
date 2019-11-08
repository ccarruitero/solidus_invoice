# frozen_string_literal: true

class Spree::Invoice < Spree::Base
  validates :doc_number, presence: true
  validates :doc_type, presence: true

  belongs_to :order
end
