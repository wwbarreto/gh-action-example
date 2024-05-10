run:
	docker compose run --build --workdir=/var/www angular /bin/bash

up:
	docker compose up --build -d angular

down:
	docker compose down

build:
	docker compose build
