package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-aws-openvpn/config"
	"github.com/hadenlabs/terraform-aws-openvpn/internal/app/external/faker"
	"github.com/hadenlabs/terraform-aws-openvpn/internal/common/log"
)

func TestRulesIngressSuccess(t *testing.T) {
	t.Parallel()
	conf := config.Must()
	logger := log.Factory(*conf)

	namespace := "terraform"
	stage := "test"
	name := faker.Server().Name()
	publicKey := "../fixtures/keys/terraform-aws-openvpn-test.pub"
	privateKey := "../fixtures/keys/terraform-aws-openvpn-test.pem"
	adminUser := "admin-username"
	storagePath := "/var/tmp/openv-vpn"
	isTest := true
	rulesIngress := []map[string]interface{}{
		{
			"from_port": 3306,
			"to_port":   3306,
			"protocol":  "tcp",
			"cidr_blocks": []string{
				"0.0.0.0/0",
			},
		},
	}
	logger.Debugf(
		"values for test terraform-aws-openvpn is",
		"namespace", namespace,
		"stage", stage,
		"name", name,
		"publicKey", publicKey,
		"privateKey", privateKey,
	)

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "openvpn-rules-ingress",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"namespace":     namespace,
			"stage":         stage,
			"name":          name,
			"public_key":    publicKey,
			"private_key":   privateKey,
			"admin_user":    adminUser,
			"storage_path":  storagePath,
			"is_test":       isTest,
			"rules_ingress": rulesIngress,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	outputInstance := terraform.Output(t, terraformOptions, "instance")
	assert.NotEmpty(t, outputInstance, outputInstance)
}
