package faker

import (
	"reflect"

	fakerTag "github.com/bxcodec/faker/v3"
)

func Generator() {
	_ = fakerTag.AddProvider("ServerNameFaker", func(v reflect.Value) (interface{}, error) {
		return Server().Name(), nil
	})
}
