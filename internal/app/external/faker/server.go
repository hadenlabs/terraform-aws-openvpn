package faker

import (
	"crypto/rand"
	"fmt"
	"math/big"

	"github.com/lithammer/shortuuid/v3"

	"github.com/hadenlabs/terraform-aws-openvpn/internal/errors"
)

type FakeServer interface {
	Name() string // Name server
}

type fakeServer struct{}

func Server() FakeServer {
	return fakeServer{}
}

var (
	names = []string{"OptimusPrime", "Wheeljack", "Bumblebee"}
)

func (n fakeServer) Name() string {
	num, err := rand.Int(rand.Reader, big.NewInt(int64(len(names))))
	if err != nil {
		panic(errors.New(errors.ErrorUnknown, err.Error()))
	}
	nameuuid := fmt.Sprintf("%s-%s", names[num.Int64()], shortuuid.New())
	return nameuuid
}
