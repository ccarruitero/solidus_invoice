# frozen_string_literal: true

class AddFieldsToSpreeInvoice < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_invoices, :communicated, :boolean, default: false
    add_column :spree_invoices, :correlative, :integer
  end
end
