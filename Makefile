setup:
	@docker-compose run app bash -c 'cabal update'

bash:
	@docker-compose run app bash

repl:
	@docker-compose run app ghci

haskell.server:
	@docker-compose run \
		--name yacrud-server \
		--service-ports \
		--rm \
		app \
		bash -c 'cabal install --lib network && ghc -e Main.main app/Main.hs'

ruby.client:
	@docker-compose run \
		--rm \
		ruby-ext \
		ruby ext/ruby_tcp_client.rb
