package config

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestAppVersionNotNil(t *testing.T) {
	conf := Initialize()
	assert.NotEmpty(t, conf.App.Version)
}
