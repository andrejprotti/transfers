# frozen_string_literal: true

class CreateBankAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :bank_accounts do |t|
      t.string :organization_name
      t.integer :balance_cents
      t.string :iban
      t.string :bic

      t.timestamps
    end
  end
end
