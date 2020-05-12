#!/bin/bash
#   Lint driver for Network Automation build pipeline
#
# Default linter paths can be overwritten using environment variables from the pipeline manager
# The assumption is that only the paths will change; the arguments will not.  This is intended
# to allow different versions to be tested in parallel by tweaking pipeline variables
ANSIBLE_LINTER=${ANSIBLE_LINTER:=venv/bin/ansible-lint}
YAML_LINTER=${YAML_LINTER:=venv/bin/yamllint}
JINJA2_LINTER=${JINJA2_LINTER:=./j2lint.py}

#------------------------------------------------------------------------------------

function flag() {
    case $2 in
    0)  ;;
    *)  echo "ERROR: $1 failed linting with exit status $2"
        ;;
    esac
}


ANSIBLE=no
YAML=no
JINJA2=no

case $1 in
ansible) ANSIBLE=yes
        ;;
yaml) YAML=yes
        ;;
jinja2) JINJA2=yes
        ;;
all)    ANSIBLE=yes
        YAML=yes
        JINJA2=yes
        ;;
esac

EXITCODE=0

case "${ANSIBLE}" in
yes)  echo 'ANSIBLE LINTING'
    echo "Ansible Linter Version: `${ANSIBLE_LINTER} --version`"
    for file in $(find playbooks/ -type f -name 'pb*.yml') $(find playbooks/ -type f -name 'playbook*.yml') $(find playbooks/roles/ -type f -name 'main.yml' -not -path "*/juniper.junos/*")
    do
        echo "LINTING ansible file: ${file}"
        ${ANSIBLE_LINTER} -c ./ansible-lint/config "${file}" 2>&1
        RESULT=$?
        let EXITCODE=(${EXITCODE} + 0${RESULT})
        flag "${file}" "${RESULT}"
    done
    ;;
esac

case "${YAML}" in
yes)  echo 'YAML LINTING'
    echo "YAML Version: `${YAML_LINTER} --version`"
    for file in $(find playbooks/roles/action_*/ -type f -name '*.yml') $(find playbooks/roles/junos_*/ -type f -name '*.yml') $(find inventory/**/ -type f -name '*.yml' -not -path "*/vault.yml") $(find playbooks/roles_panos/panos_*/ -type f -name '*.yml')
    do
        echo "${file}: "
        ${YAML_LINTER} -c ./yamllint/config "${file}"
        RESULT=$?
        let EXITCODE=(${EXITCODE} + 0${RESULT})
        flag "${file}" "${RESULT}"
    done
    ;;
esac

case "${JINJA2}" in
yes) echo ">>> LINTING jinja2 files"
    for file in $(find playbooks/ -type f -name '*.j2')
    do
        ${JINJA2_LINTER} "${file}"
        RESULT=$?
        let EXITCODE=(${EXITCODE} + 0${RESULT})
        flag "${file}" "${RESULT}"
    done
    ;;
esac

exit "${EXITCODE}"
