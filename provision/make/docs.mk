#
# See ./CONTRIBUTING.rst
#

FILE_README=$(ROOT_DIR)/README.md

docs:
	make docs.help

docs.help:
	@echo '    Docs:'
	@echo ''
	@echo '        docs.show                  Show restview README'
	@echo '        docs.make                  Make documentation html'
	@echo '        docs.terraform             generated docs for terraform'
	@echo ''

docs.terraform:
	$(call terraform-docs, ${TERRAFORM_README_FILE}, \
			'This document gives an overview of variables used in the platform of the ${PROJECT}.', \
			variables.tf)

docs.show:
	$(PIPENV_RUN) restview ${FILE_README}

docs.make:
	$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/dev.yml run --rm docs bash -c "cd docs && make html"
