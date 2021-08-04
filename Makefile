setup:
	@docker-compose run app bash -c 'stack setup && \
		stack install network split'

bash:
	@docker-compose run app bash

repl:
	@docker-compose run app stask repl

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
