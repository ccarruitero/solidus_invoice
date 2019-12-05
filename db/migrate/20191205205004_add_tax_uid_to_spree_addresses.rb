# frozen_string_literal: true

class AddTaxUidToSpreeAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_addresses, :tax_uid, :string
  end
end
