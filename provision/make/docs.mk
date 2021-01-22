#
# See ./docs/contributing.md
#

docs:
	make docs.help

docs.help:
	@echo '    Docs:'
	@echo ''
	@echo '        docs.show                  Show mkdocs'
	@echo '        docs.build                 build mkdocs'
	@echo '        docs.terraform             generated docs for terraform'
	@echo ''

docs.terraform:
	$(call terraform-docs, ${TERRAFORM_README_FILE}, \
			'This document gives an overview of variables used in the platform of the ${PROJECT}.', \
			variables.tf)

docs.show:
	$(PIPENV_RUN) mkdocs serve

docs.build:
	$(PIPENV_RUN) mkdocs build

