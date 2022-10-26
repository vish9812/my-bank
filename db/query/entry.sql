-- name: CreateEntry :one
INSERT INTO entries (account_id, amount)
values ($1, $2)
returning *;
-- name: GetEntry :one
SELECT *
FROM entries
WHERE id = $1
LIMIT 1;
-- name: GetEntries :many
SELECT *
FROM entries
ORDER BY id
LIMIT $1 offset $2;