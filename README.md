# Transfers

This application sets up a simple API that accepts transfer requests and if the account has enough balance, subtracts from it and creates the transfers in the db! :tada: :tada: :tada:
It uses docker, docker-compose, rails and postgres to achieve such a feat.

## Requirements
 - A nice and recent Docker and docker-compose release on your machine.
 - https://docs.docker.com/install/
 - https://docs.docker.com/compose/install/

## Set up!

Run these commands in order, please:
 
	docker-compose build

	docker-compose run web rake db:setup

	docker-compose run web rake db:migrate

## Running the app!

	docker-compose up -d --build

## Running the test suite!

	docker-compose run -e "RAILS_ENV=test" web bundle exec rspec

## A curl to help further testing

	curl --location 'localhost:3000/transfer' \
	--header 'Content-Type: application/json' \
	--data '{
	        "organization_name": "ACME Corp",
	        "organization_bic": "OIVUSCLQXXX",
	        "organization_iban": "FR10474608000002006107XXXXX",
	        "credit_transfers": [
	          {
	            "amount": "14.5",
	            "counterparty_name": "Bip Bip",
	            "counterparty_bic": "CRLYFRPPTOU",
	            "counterparty_iban": "EE383680981021245685",
	            "description": "Wonderland/4410"
	          },
	          {
	            "amount": "61238",
	            "counterparty_name": "Wile E Coyote",
	            "counterparty_bic": "ZDRPLBQI",
	            "counterparty_iban": "DE9935420810036209081725212",
	            "description": "//TeslaMotors/Invoice/12"
	          },
	          {
	            "amount": "999",
	            "counterparty_name": "Bugs Bunny",
	            "counterparty_bic": "RNJZNTMC",
	            "counterparty_iban": "FR0010009380540930414023042",
	            "description": "2020 09 24/2020 09 25/GoldenCarrot/"
	          }
	        ]
	      }'

## Known ToDo's:
	- Cleanup rails bloat
	- Refactor to fix rubocop suggestions, shorten methods, extract parts to appropriate helper modules, etc.
	- Add more unit test scenarios
	- Put all db actions within commit-rollback blocks

## More info:
	First tried to code all of this on my SteamDeck using its ArchLinux OS. That was a mistake as Steam has some restrictions, that took me some hours.
	Then I went for an old boilerplate project I had and tried to update it. Wasted several hours on that. That was not my smartest idea.
	After that I decided to try a hanami project from scratch, seemed like a more lean solution for a small project. Spent several hours on that until realizing I would already be done with rails.
	Finally went for rails and got to where we are now. Oh well. Hope you all enjoy it!

André Protti