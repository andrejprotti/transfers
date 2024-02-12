# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transfers', type: :request do
  describe 'POST /transfer' do
    context 'with valid parameters' do
      let!(:valid_transfer) do
        {
          "organization_name": 'ACME Corp',
          "organization_bic": 'OIVUSCLQXXX',
          "organization_iban": 'FR10474608000002006107XXXXX',
          "credit_transfers": [
            {
              "amount": '14.5',
              "counterparty_name": 'Bip Bip',
              "counterparty_bic": 'CRLYFRPPTOU',
              "counterparty_iban": 'EE383680981021245685',
              "description": 'Wonderland/4410'
            },
            {
              "amount": '61238',
              "counterparty_name": 'Wile E Coyote',
              "counterparty_bic": 'ZDRPLBQI',
              "counterparty_iban": 'DE9935420810036209081725212',
              "description": '//TeslaMotors/Invoice/12'
            },
            {
              "amount": '999',
              "counterparty_name": 'Bugs Bunny',
              "counterparty_bic": 'RNJZNTMC',
              "counterparty_iban": 'FR0010009380540930414023042',
              "description": '2020 09 24/2020 09 25/GoldenCarrot/'
            }
          ]
        }
      end

      before do
        post '/transfer', params: valid_transfer
      end

      # it 'returns the title' do
      #   expect(json['title']).to eq(my_post.title)
      # end

      # it 'returns the content' do
      #   expect(json['content']).to eq(my_post.content)
      # end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let!(:invalid_transfer) do
        {
          "organization_name": 'DERP Corp',
          "organization_bic": 'OIVUSCLQXXX',
          "organization_iban": 'FR10474608000002006107XXXXX',
          "credit_transfers": [
            {
              "amount": '14.5',
              "counterparty_name": 'Bip Bip',
              "counterparty_bic": 'CRLYFRPPTOU',
              "counterparty_iban": 'EE383680981021245685',
              "description": 'Wonderland/4410'
            },
            {
              "amount": '61238',
              "counterparty_name": 'Wile E Coyote',
              "counterparty_bic": 'ZDRPLBQI',
              "counterparty_iban": 'DE9935420810036209081725212',
              "description": '//TeslaMotors/Invoice/12'
            },
            {
              "amount": '999',
              "counterparty_name": 'Bugs Bunny',
              "counterparty_bic": 'RNJZNTMC',
              "counterparty_iban": 'FR0010009380540930414023042',
              "description": '2020 09 24/2020 09 25/GoldenCarrot/'
            }
          ]
        }
      end
      before do
        post '/api/v1/posts', params: invalid_transfer
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
