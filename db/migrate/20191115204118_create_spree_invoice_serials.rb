# frozen_string_literal: true

class CreateSpreeInvoiceSerials < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_invoice_serials do |t|
      t.string :serial
      t.integer :store_id

      t.timestamps
    end
  end
end
