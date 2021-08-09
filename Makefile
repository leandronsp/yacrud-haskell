setup.volume:
	@docker volume create --name=stackCache

setup: setup.volume
	@docker-compose run --rm app bash -c 'stack build'

bash:
	@docker-compose run --rm app bash

repl:
	@docker-compose run --rm app stack repl

haskell.server:
	@docker-compose run \
		--name yacrud-server \
		--service-ports \
		--rm \
		app \
		bash -c 'stack ghc -- app/*.hs -e main'

ruby.client:
	@docker-compose run \
		--rm \
		ruby-ext \
		ruby ext/ruby_tcp_client.rb
