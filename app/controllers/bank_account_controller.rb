# frozen_string_literal: true

class BankAccountController < ApplicationController
  def show
    id = params.extract_value(:id)
    @bank_account = BankAccount.find(id).first

    respond_to do |format|
      format.json do
        render json: @bank_account.to_json
      end
    end
  end
end
