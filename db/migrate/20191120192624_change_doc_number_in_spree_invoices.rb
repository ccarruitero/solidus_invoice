# frozen_string_literal: true

class ChangeDocNumberInSpreeInvoices < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :spree_invoices do |t|
        dir.up   { t.change :doc_number, :integer }
        dir.down { t.change :doc_number, :string }
      end
    end
  end
end
