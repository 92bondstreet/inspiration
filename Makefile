SHELL := /bin/bash

.PHONY: resume inspiration

alias: ## alias to medium.now.sh
	now alias $(filter-out $@,$(MAKECMDGOALS)) medium

deploy: ## deploy to medium.now.sh
	now --public -n medium

login: ## login with now
	now login

medium: ## Generate the html output from README.md
	docker run --rm -v `pwd`:/data jpbernius/pandoc --template template.html -o index.html -s README.md

help: ## This help dialog.
	@IFS=$$'\n' ; \
	intro_lines=(`fgrep -h "###" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/###//'`); \
	for line in $${intro_lines[@]}; do \
		printf "%s\n" $$line; \
	done; \
	help_lines=(`fgrep -h -e "##" $(MAKEFILE_LIST) | fgrep -v "###" | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/:/'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$':' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf '\033[36m'; \
		printf "%-30s %s" $$help_command ; \
		printf '\033[0m'; \
		printf "%s\n" $$help_info; \
	done

# %: rule which match any task name
%:

.DEFAULT_GOAL := help
