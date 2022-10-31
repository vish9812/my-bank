package db

import (
	"context"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"github.com/vish9812/mybank/util"
)

func createRandomUser(t *testing.T) User {
	arg := CreateUserParams{
		Username:       util.RandomOwner(),
		HashedPassword: util.RandomString(6),
		FullName:       util.RandomOwner(),
		Email:          util.RandomEmail(),
	}

	user, err := testQueries.CreateUser(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, user)

	assert.Equal(t, arg.Username, user.Username)
	assert.Equal(t, arg.HashedPassword, user.HashedPassword)
	assert.Equal(t, arg.FullName, user.FullName)
	assert.Equal(t, arg.Email, user.Email)

	assert.True(t, user.PasswordChangedAt.IsZero())
	assert.NotZero(t, user.CreatedAt)

	return user
}

func TestCreateUser(t *testing.T) {
	createRandomUser(t)
}

func TestGetUser(t *testing.T) {
	user1 := createRandomUser(t)
	user2, err := testQueries.GetUser(context.Background(), user1.Username)
	require.NoError(t, err)
	require.NotEmpty(t, user2)

	assert.Equal(t, user1.Username, user2.Username)
	assert.Equal(t, user1.HashedPassword, user2.HashedPassword)
	assert.Equal(t, user1.FullName, user2.FullName)
	assert.Equal(t, user1.Email, user2.Email)
	assert.WithinDuration(t, user1.PasswordChangedAt, user2.PasswordChangedAt, time.Second)
	assert.WithinDuration(t, user1.CreatedAt, user2.CreatedAt, time.Second)
}
