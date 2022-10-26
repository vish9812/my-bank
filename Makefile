.PHONY: psql up down sqlc test

psql:
	PGPASSWORD=mostest psql --host=localhost --dbname=my_bank --username=mmuser

get-migrate:
	curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz | tar xvz \
	&& sudo mv migrate.linux-amd64 /usr/bin/migrate \
	&& which migrate

up:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank" -verbose up

down:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...