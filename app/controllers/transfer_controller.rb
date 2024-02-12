# frozen_string_literal: true

class TransferController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    post_contents = request.raw_post
    transfer_json = JSON.parse(post_contents)

    bank_account = BankAccount.find_by(organization_name: transfer_json['organization_name'],
                                       iban: transfer_json['organization_iban'], bic: transfer_json['organization_bic'])

    total_amount = 0

    (transfer_json['credit_transfers']).each do |transfer|
      transfer_amount = to_cents(transfer['amount'])
      total_amount += transfer_amount
    end

    if bank_account
      # check if there's enough money in the account
      if bank_account.balance_cents < total_amount
        render json: 'Not enough balance!.'.to_json, status: :unprocessable_entity
        return
      end

      # create the transfers and update the balance.
      bank_account.balance_cents -= total_amount
      bank_account.save

      (transfer_json['credit_transfers']).each do |transfer|
        new_transfer = Transfer.new
        new_transfer.counterparty_name = transfer['counterparty_name']
        new_transfer.counterparty_iban = transfer['counterparty_iban']
        new_transfer.counterparty_bic = transfer['counterparty_bic']
        new_transfer.amount_cents = to_cents(transfer['amount'])
        new_transfer.bank_account_id = transfer['bank_account_id']
        new_transfer.description = transfer['description']
        new_transfer.save
      end

      render json: 'Balance updated and transfers created successfully!'.to_json, status: :created
      nil

    # in case the account is not found
    else
      render json: 'No bank account found.'.to_json, status: :not_found
    end
  end

  private

  def to_cents(amount)
    if amount.include?('.')
      (amount.to_f * 100).to_i
    else
      amount.to_i * 100
    end
  end
end
