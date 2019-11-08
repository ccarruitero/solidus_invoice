# frozen_string_literal: true

class CreateSpreeInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_invoices do |t|
      t.string :doc_number
      t.string :doc_type
      t.integer :order_id

      t.timestamps
    end
  end
end
