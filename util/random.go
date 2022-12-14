package util

import (
	"fmt"
	"math/rand"
	"strings"
	"time"
)

const alphabets = "abcdefghijklmnopqrstuvwxyz"

func init() {
	rand.Seed(time.Now().UnixNano())
}

// RandomInt64 generates a random number between min and max
func RandomInt64(min, max int64) int64 {
	return min + rand.Int63n(max-min+1)
}

// RandomString generates a random string of length n
func RandomString(n int) string {
	var sb strings.Builder
	k := len(alphabets)

	for i := 0; i < n; i++ {
		c := alphabets[rand.Intn(k)]
		sb.WriteByte(c)
	}

	return sb.String()
}

// RandomOwner generates a random Owner name
func RandomOwner() string {
	return RandomString(6)
}

// RandomEmail generates a random email
func RandomEmail() string {
	return fmt.Sprintf("%s@email.com", RandomString(6))
}

// RandomMoney generates a random amount of money
func RandomMoney() int64 {
	return RandomInt64(0, 1000)
}

// RandomCurrency generates a random Currency code
func RandomCurrency() string {
	currencies := []string{"USD", "EUR"}
	n := len(currencies)
	return currencies[rand.Intn(n)]
}
