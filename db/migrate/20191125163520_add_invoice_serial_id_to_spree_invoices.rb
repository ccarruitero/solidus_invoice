# frozen_string_literal: true

class AddInvoiceSerialIdToSpreeInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_invoices, :invoice_serial_id, :integer
  end
end
