.PHONY: psql up down up1 down1 sqlc test server mock

psql:
	PGPASSWORD=mostest psql --host=localhost --dbname=my_bank --username=mmuser

get-migrate:
	curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz | tar xvz \
	&& sudo mv migrate /usr/bin \
	&& which migrate

up:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose up

up1:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose up 1

down:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose down

down1:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen --package mockdb --destination db/mock/store.go github.com/vish9812/mybank/db/sqlc Store