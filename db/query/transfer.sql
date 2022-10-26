-- name: CreateTransfer :one
INSERT INTO transfers (from_account_id, to_account_id, amount)
values ($1, $2, $3)
returning *;
-- name: GetTransfer :one
SELECT *
FROM transfers
WHERE id = $1
LIMIT 1;
-- name: GetTransfers :many
SELECT *
FROM transfers
ORDER BY id
LIMIT $1 offset $2;