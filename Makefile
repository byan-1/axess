export PYTHON_COMMAND=python3
export MANAGE_PATH=manage.py

# As we're using user-local installs inside the docker-container we need
# to be cautious about uprading pip and not confusing it with the
# globally installed version. This will take `$PYTHONUSERBASE` and `$PIP_USER`
# into account.
# See https://github.com/pypa/pip/issues/7205
export PIP_COMMAND=$(PYTHON_COMMAND) -m pip
export PROJECT_NAME=axess

.PHONY: lint
lint: ## lint the code
	black --check src/

.PHONY: web-up
web-up:
	npm run build
	docker-compose up &

.PHONY: shell
shell: ## run a shell in the web container
	docker exec -it $(CONTAINER_NAME) bash

.PHONY: web-down
web-down:
	docker-compose down

.PHONY: web-clear
web-clear: web-down
	docker volume rm axess_web-db-data

.PHONY: dev-up
dev-up:
	docker-compose -f docker-compose-devservice.yml up &

.PHONY: dev-down
dev-down:
	docker-compose -f docker-compose-devservice.yml down

.PHONY: dev-clear
dev-clear: dev-down
	docker volume rm axess_dev-db-data

.PHONY: bootstrap
bootstrap-dev:
	scripts/bootstrap.sh
	scripts/bootstrap-dev.sh

.PHONY: install
install: bootstrap-dev
	$(PIP_COMMAND) install -r requirements/requirements.txt
	$(PIP_COMMAND) install -r requirements/requirements-dev.txt

.PHONY: devserver
devserver:
	npx concurrently "npm run dev" "$(PYTHON_COMMAND) $(MANAGE_PATH) runserver 0.0.0.0:8000"

.PHONY: test
test:
	$(PYTHON_COMMAND) $(MANAGE_PATH) test src/
