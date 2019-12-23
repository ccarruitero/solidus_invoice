# frozen_string_literal: true

class AddPreferencesToSpreeInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_invoices, :preferences, :text
  end
end
