#
# See ./docs/contributing.md
#

## show keys.help
.PHONY: keys.help
keys.help:
	@echo '    keys:'
	@echo ''
	@echo '        keys                     help keys'
	@echo '        keys.openssl             make key openssl by stage'
	@echo '        keys.pem                 make key openssl by stage'
	@echo ''

## show help keys commands
.PHONY: keys
keys:
	make keys.help

## generate key openssl
.PHONY: keys.openssl
keys.openssl:
	@if [ -z "${stage}" ]; then \
		echo "is necessary add a stage"; \
		exit 2; \
	fi
	mkdir -p ${KEYBASE_PATH}/${stage}/openssl/
	openssl genrsa -out ${PROJECT}-${stage}.pem 2048
	openssl rsa -in ${PROJECT}-${stage}.pem -pubout -out ${PROJECT}-${stage}.public.pem
	mv ${PROJECT}-${stage}.pem ${KEYBASE_PATH}/${stage}/openssl/${PROJECT}-${stage}.pem
	mv ${PROJECT}-${stage}.public.pem ${KEYBASE_PATH}/${stage}/openssl/${PROJECT}-${stage}.pem

## Generate key rsa pem
.PHONY: keys.pem
keys.pem:
	@if [ -z "${stage}" ]; then \
		echo "is necessary add a stage"; \
		exit 2; \
	fi
	@ssh-keygen -q -m PEM -t rsa -b 4096 -C "admin@${PROJECT}-${stage}.com" -f ${PROJECT}-${stage} -P ""
	@openssl rsa -in ${PROJECT}-${stage} -outform pem > ${PROJECT}-${stage}.pem
	@chmod 0600 ${PROJECT}-${stage}.pem
