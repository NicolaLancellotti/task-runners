#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

ROOT_DIR=$(dirname "$(readlink -f "$0")")
cd ${ROOT_DIR}

DERIVED_DATA=./DerivedData
VENV=${DERIVED_DATA}/venv
PYTHON=${VENV}/bin/python3
COVERAGE="${VENV}/bin/coverage"

JUNIT_XML_PATH=${DERIVED_DATA}/junitxml.xml
COVERAGE_PATH=${DERIVED_DATA}/coverage.coverage
COVERAGE_PATH_XML=${DERIVED_DATA}/coverage.xml

PACKAGE="my_package"
TESTS="tests"
SRC="${PACKAGE} ${TESTS}"

function clean() {
    rm -rf ${DERIVED_DATA}
}

function venv-create() {
    python3 -m venv ${VENV}
    ${PYTHON} -m pip install --upgrade pip
    ${PYTHON} -m pip install -r requirements.txt
}

function venv-clean() {
    rm -rf ${VENV}
}

function format() {
    ${PYTHON} -m black ${SRC} $@
	${PYTHON} -m isort ${SRC} --profile black $@
}

function format-check() {
    format --check
}

function lint() {
    ${PYTHON} -m pyright --pythonpath=${PYTHON}
}

function test() {
    ${PYTHON} -m pytest ${TESTS}
}

function test-and-coverage() {
    ${COVERAGE} run --source=. --data-file=${COVERAGE_PATH} -m \
        pytest ${TESTS} --junitxml=${JUNIT_XML_PATH}
    ${COVERAGE} xml --data-file=${COVERAGE_PATH} -o ${COVERAGE_PATH_XML}
}

function coverage-report() {
    ${COVERAGE} report -m --data-file=${COVERAGE_PATH}
}

function run() {
    ${PYTHON} -m ${PACKAGE} $@
}

function help {
  compgen -A function
}

$*

