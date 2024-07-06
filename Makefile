RUN=./script.sh

# ______________________________________________________________________________

.SILENT:
.NOTPARALLEL:

.PHONY: help - Lists targets.
help:
	echo "Targets:"
	sed -nr 's/^.PHONY: (.*) - (.*)/\1|\2/p' ${MAKEFILE_LIST} | \
		awk -F '|' '{printf "* %-30s %s\n", $$1, $$2}' | sort

# ______________________________________________________________________________

.PHONY: all - Format, lint and test.
all:	venv-create \
		format \
		lint \
		test

# ______________________________________________________________________________

.PHONY: clean - Clean the DerivedData folder.
clean:
	${RUN} clean

# ______________________________________________________________________________

.PHONY: venv-create - Create a Python virtual environment.
venv-create:
	${RUN} venv-create

# ______________________________________________________________________________

.PHONY: venv-clean - Clean the Python virtual environment.
venv-clean:
	${RUN} venv-clean	

# ______________________________________________________________________________

.PHONY: format - Format.
format:
	${RUN} format

# ______________________________________________________________________________

.PHONY: lint - Lint.
lint:
	${RUN} lint

# ______________________________________________________________________________

.PHONY: test - Test.
test:
	${RUN} test

# _____________________________________________________________________________

include .env
ENVIRONMENT_VARIABLE_1="value 1"

.PHONY: print-env-vars - Print some environment variables.
print-env-vars:
	echo ENVIRONMENT_VARIABLE_1 = ${ENVIRONMENT_VARIABLE_1}
	echo ENVIRONMENT_VARIABLE_2 = ${ENVIRONMENT_VARIABLE_2}

# ______________________________________________________________________________

.PHONY: run - Run the program.
# command: make run ARGS=--help
run:
	${RUN} run ${ARGS}

# ______________________________________________________________________________

.PHONY: run-var-required - Run the program.
# command: make run-var-required VALUE=B
run-var-required:
ifndef VALUE
	$(error VALUE not set)
else
	${RUN} run --value=${VALUE} 
endif

.PHONY: run-var-default - Run the program.
# command: make run-var-default VALUE=B
run-var-default:
	${MAKE} run-var-required VALUE=$(if $(VALUE),$(VALUE),"B")

# ______________________________________________________________________________

ROOT_DIR=$(shell cd .; pwd)

.PHONY: show-root-dir - Show root directory.
show-root-dir:
	@echo ${ROOT_DIR}

# ______________________________________________________________________________

ifeq ($(shell uname), Darwin)
    DARWIN=true
else
    DARWIN=false
endif

.PHONY: show-is-darwin - Show if is Darwin.
show-is-darwin:
	echo ${DARWIN}
