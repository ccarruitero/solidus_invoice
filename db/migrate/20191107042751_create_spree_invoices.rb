# frozen_string_literal: true

class CreateSpreeInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_invoices do |t|
      t.integer :doc_number
      t.integer :order_id
      t.integer :invoice_serial_id
      t.boolean :communicated, default: false

      t.timestamps
    end
  end
end
