.PHONY: psql up down sqlc test

psql:
	PGPASSWORD=mostest psql --host=localhost --dbname=my_bank --username=mmuser

up:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank" -verbose up

down:
	migrate -path db/migration -database "postgresql://mmuser:mostest@localhost:5432/my_bank" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...