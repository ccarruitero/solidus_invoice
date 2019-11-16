# frozen_string_literal: true

class AddDocTypeToSpreeInvoiceSerials < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_invoice_serials, :doc_type, :string
  end
end
