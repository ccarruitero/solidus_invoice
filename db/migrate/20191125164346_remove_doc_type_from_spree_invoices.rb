# frozen_string_literal: true

class RemoveDocTypeFromSpreeInvoices < ActiveRecord::Migration[6.0]
  def change
    remove_column :spree_invoices, :doc_type, :string
  end
end
