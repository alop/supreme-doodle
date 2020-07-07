#!/usr/bin/env make

VENV_NAME?=.venv
VENV_ACTIVATE=. $(VENV_NAME)/bin/activate
PIP_VERSION?=19.0.3

.PHONY: $(VENV_NAME)
$(VENV_NAME):
	python3 -m venv $(VENV_NAME) \
		--copies --clear \
		&& $(VENV_ACTIVATE) \
		&& pip install --upgrade pip==$(PIP_VERSION) \
		&& pip install -r requirements.txt

.PHONY: clean
clean:
	$(RM) -rf $(VENV_NAME)
