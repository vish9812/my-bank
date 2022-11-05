.PHONY: psql migrate-up migrate-down migrate-up1 migrate-down1 migrate-up-docker migrate-down-docker migrate-up1-docker migrate-down1-docker sqlc test server mock

psql:
	PGPASSWORD=mostest psql --host=localhost --dbname=my_bank --username=mmuser

get-migrate:
	curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz | tar xvz \
	&& sudo mv migrate /usr/bin \
	&& which migrate

migrate-up:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose up

migrate-up1:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose up 1

migrate-down:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose down

migrate-down1:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose down 1

migrate-up-docker:
	migrate -path db/migration -database "postgresql://root:secret@postgres:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose up

migrate-up1-docker:
	migrate -path db/migration -database "postgresql://root:secret@postgres:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose up 1

migrate-down-docker:
	migrate -path db/migration -database "postgresql://root:secret@postgres:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose down

migrate-down1-docker:
	migrate -path db/migration -database "postgresql://root:secret@postgres:5432/my_bank?sslmode=disable&connect_timeout=10" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen --package mockdb --destination db/mock/store.go github.com/vish9812/mybank/db/sqlc Store