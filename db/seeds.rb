# frozen_string_literal: true

BankAccount.destroy_all

BankAccount.create!(organization_name: 'ACME Corp', balance_cents: 99_999_999, iban: 'FR10474608000002006107XXXXX',
                    bic: 'OIVUSCLQXXX')

Rails.logger.debug "Created #{BankAccount.count} bank accounts."
