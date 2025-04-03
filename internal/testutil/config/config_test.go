package config

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	coreconfig "github.com/hadenlabs/terraform-aws-openvpn/config"
)

func TestConfigLoadEnvSuccess(t *testing.T) {
	conf, err := LoadEnvWithFilename("./mocking/config.env")
	require.NoError(t, err, "Expected no error when loading a valid env file")
	assert.IsType(t, &coreconfig.Config{}, conf)
	assert.Equal(t, "zap", conf.Log.Provider, conf.Log.Provider)
}

func TestConfigMustLoadEnvWithPanic(t *testing.T) {
	assert.Panics(
		t,
		func() { MustLoadEnvWithFilename("./mocking/notfound.env") },
		"The code did not panic",
	)
}

func TestConfigLoadEnvFailed(t *testing.T) {
	conf, err := LoadEnvWithFilename("./mocking/notfound.env")

	require.Error(t, err, "An error was expected when loading a non-existent file.")

	require.IsType(t, &coreconfig.Config{}, conf)

	require.Empty(t, conf, "Config should be empty when loading a non-existent file.")
}
