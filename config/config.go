package config

import (
	env "github.com/caarlos0/env/v6"
	log "github.com/sirupsen/logrus"

	"github.com/joho/godotenv"

	"github.com/hadenlabs/terraform-aws-openvpn/internal/errors"
	"github.com/hadenlabs/terraform-aws-openvpn/internal/version"
)

// Config struct field.
type Config struct {
	App App
	Log Log
}

const (
	applicationName = "terraform-aws-openvpn"
)

// ReadConfig read values and files for config.
func ReadConfig() (*Config, error) {
	conf := New()

	tag := version.Short()
	conf.App.Version = tag

	if err := godotenv.Load(); err != nil {
		log.Debugf("unable to load .env file: %s %s", applicationName, err)
	}

	if err := env.Parse(conf); err != nil {
		panic(errors.Wrapf(err, errors.ErrorParseConfig, "not allowed parse env with %v", conf))
	}

	return conf, nil
}

// Initialize new instance.
func Initialize() *Config {
	conf, err := ReadConfig()
	if err != nil {
		panic(errors.Wrap(err, errors.ErrorReadConfig, ""))
	}
	return conf
}

func Must() *Config {
	conf, err := ReadConfig()
	if err != nil {
		panic(errors.Wrapf(err, errors.ErrorReadConfig, "config: %v", conf))
	}
	return conf
}

// New create config.
func New() *Config {
	return &Config{}
}
