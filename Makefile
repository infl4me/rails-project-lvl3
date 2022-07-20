lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

format:
	bundle exec rubocop -a

test:
	bin/rails test

ci-setup:
	cp -n .env.example .env || true
	yarn install
	bundle install --without production development
	RAILS_ENV=test bin/rails db:prepare

check: lint test

deploy:
	git push heroku main

.PHONY: test