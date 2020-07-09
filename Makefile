#!/usr/bin/env make

VENV_NAME?=.venv
VENV_ACTIVATE=. $(VENV_NAME)/bin/activate
PIP_VERSION?=19.0.3
SSH_KEY_EXISTS ?=$(shell [ -e demo_key ] && echo 1 || echo 0)

.PHONY: $(VENV_NAME)
$(VENV_NAME):
	python3 -m venv $(VENV_NAME) \
		--copies --clear \
		&& $(VENV_ACTIVATE) \
		&& pip install --upgrade pip==$(PIP_VERSION) \
		&& pip install -r requirements.txt

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

.PHONY: clean
clean: guard-AWS_SECRET_KEY guard-AWS_ACCESS_KEY_ID guard-AWS_REGION
	$(VENV_ACTIVATE)
	ansible-playbook -i inventory/ playbooks/remove_infra.yml
	$(RM) -rf $(VENV_NAME)
	$(RM) demo_key*

.PHONY: prep
prep: .venv
ifeq ($(SSH_KEY_EXISTS),0)
	ssh-keygen -t rsa -N "" -C "Demo key" -f demo_key
endif

.PHONY: deploy
deploy: guard-AWS_SECRET_KEY guard-AWS_ACCESS_KEY_ID guard-AWS_REGION
	$(VENV_ACTIVATE)
	ansible-playbook --private-key demo_key -i inventory/ playbooks/deploy_infra.yml
