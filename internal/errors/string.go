package errors

import (
	valid "github.com/asaskevich/govalidator"
)

// ToUnderScore converts CamalCase to under_score case
// Source: https://gist.github.com/zxh/cee082053aa9674812e8cd4387088301
func ToUnderScore(name string) string {
	return valid.CamelCaseToUnderscore(name)
}
