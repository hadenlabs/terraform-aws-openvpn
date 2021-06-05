package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestBasicSuccess(t *testing.T) {
	t.Parallel()

	namespace := "terraform"
	environment := "test"
	stage := "test"
	name := "openvpn"
	region := "us-east-1"
	publicKey := "../fixtures/keys/terraform-aws-openvpn-test.pub"
	privateKey := "../fixtures/keys/terraform-aws-openvpn-test.pem"
	adminUser := "admin-username"
	storagePath := "~/tmp/openv-vpn"
	isTest := true

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "openvpn-basic",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"namespace":    namespace,
			"environment":  environment,
			"stage":        stage,
			"name":         name,
			"aws_region":   region,
			"public_key":   publicKey,
			"private_key":  privateKey,
			"admin_user":   adminUser,
			"storage_path": storagePath,
			"is_test":      isTest,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	outputInstance := terraform.Output(t, terraformOptions, "instance")
	assert.NotEmpty(t, outputInstance, outputInstance)
}
