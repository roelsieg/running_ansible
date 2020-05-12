#
# Linting Makefile
#
#    The actual linting is pushed to shell scripts due to a particularly annoying
#    problem with exit codes + shell + pipes, made more annoying because in Makefiles
#    there's another level of indirection.
#       tl;dr: `find -exec linter` AND `find | xargs linter` don't fail if exit != 0
#              ==> If >1 file is being linted, only the last file's exit is ever used.

lint: lint_ansible lint_yaml lint_jinja2

lint_ansible:
	./lint_driver.sh ansible

lint_yaml:
	./lint_driver.sh yaml

lint_jinja2:
	./lint_driver.sh jinja2

playbook:
	./playbook_driver.sh
