#!/bin/bash
# Playbook Runner Teamcity Agent for Network Automation
# Set environment variables, show set variables and place them after the ansible-playbook command
#
ANSIBLE_PLAYBOOK=${ANSIBLE_PLAYBOOK:=venv/bin/ansible-playbook}

function flag() {
    case $2 in
    0)  ;;
    *)  echo "ERROR: $1 failed playbook with exit status $2"
        ;;
    esac
}

EXITCODE=0

echo 'Ansible Playbook'
INVENTORY=$ANSIBLE_INVENTORY
PLAYBOOK=$ANSIBLE_PLAYBOOK_PATH
VAULT_SCRIPT="vault/get-vault-password.sh"
LIMIT=$ANSIBLE_LIMIT
VERBOSITY=$ANSIBLE_VERBOSITY
VAULT_PASSWORD=$ANSIBLE_VAULT_PASSWORD
ANSIBLE_USER=$ANSIBLE_USER
ANSIBLE_USER_PASSWORD=$ANSIBLE_USER_PASSWORD
echo "Ansible configuration that will be used:"
echo "Inventory     ${INVENTORY}"
echo "Playbook      ${PLAYBOOK}"
echo "Vault Script  ${VAULT_SCRIPT}"
echo "Limit         ${LIMIT}"
echo "Verbosity     ${VERBOSITY}"
echo "User:         ${ANSIBLE_USER}"

${ANSIBLE_PLAYBOOK} "${PLAYBOOK}" --inventory-file "${INVENTORY}" --vault-password-file "${VAULT_SCRIPT}" --limit "${LIMIT}" --extra-vars "ansible_user=${ANSIBLE_USER} ansible_password=${ANSIBLE_USER_PASSWORD}"
RESULT=$?
let EXITCODE=(${EXITCODE}+ 0${RESULT})
flag "${PLAYBOOK}" "${RESULT}"

exit "${EXITCODE}"
