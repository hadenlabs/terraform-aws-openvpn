## Terraform
.PHONY: terraform.help

terraform.help:
	@echo '    terraform:'
	@echo ''
	@echo '        terraform                show help'
	@echo '        terraform.docs           generate documentation variables'
	@echo ''

terraform:
	make terraform.help


terraform.docs:
	$(call terraform-docs, ${TERRAFORM_README_FILE}, \
			'This document gives an overview of variables used in the platform of the ${PROJECT}.', \
			variables.tf)
.PHONY: terraform.docs
