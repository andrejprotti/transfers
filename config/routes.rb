# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'bank_account/:id' => 'bank_account#show'
  post 'transfer' => 'transfer#create'
end
