package config

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestInitialize(t *testing.T) {
	conf := Initialize()
	assert.IsType(t, &Config{}, conf)
}

func TestNewConfig(t *testing.T) {
	assert.IsType(t, &Config{}, New())
}
