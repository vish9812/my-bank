-- name: CreateAccount :one
INSERT INTO accounts (owner, balance, currency)
values ($1, $2, $3)
returning *;

-- name: GetAccount :one
SELECT *
FROM accounts
WHERE id = $1
LIMIT 1;

-- name: GetAccountForUpdate :one
SELECT *
FROM accounts
WHERE id = $1
LIMIT 1 
FOR NO KEY UPDATE;

-- name: GetAccounts :many
SELECT *
FROM accounts
WHERE owner = $1
ORDER BY id
LIMIT $2 offset $3;

-- name: UpdateAccount :one
UPDATE accounts
set balance = $2
WHERE id = $1
returning *;

-- name: AddAccountBalance :one
UPDATE accounts
set balance = balance + sqlc.arg(amount)
WHERE id = sqlc.arg(id)
returning *;

-- name: DeleteAccount :exec
delete FROM accounts
WHERE id = $1;