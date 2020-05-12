#!/usr/bin/env bash
find . -type f -name \*.y*ml -exec venv/bin/yamllint {} \;
find . -type f -name \playbook*.y*ml -exec venv/bin/ansible-lint --exclude=/etc/ansible/roles/ {} \;
#find . -type f -name \*.j2 -exec j2lint.py {} \;
