# frozen_string_literal: true

class CreateTransfers < ActiveRecord::Migration[7.1]
  def change
    create_table :transfers do |t|
      t.string :counterparty_name
      t.string :counterparty_iban
      t.string :counterparty_bic
      t.integer :amount_cents
      t.integer :bank_account_id
      t.string :description

      t.timestamps
    end
  end
end
