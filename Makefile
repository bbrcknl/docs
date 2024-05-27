# Copyright 2020 seL4 Project a Series of LF Projects, LLC.
# SPDX-License-Identifier: BSD-2-Clause

default: serve --trace

.PHONY: ruby_deps
ruby_deps: Gemfile Gemfile.lock
	bundle install

# The following rules generate a yaml file that contains file modification metadata
# provided by git.  The format is:
#
# date: Tue Mar 13 19:11:51 2018 +1100
# timestamps:
#   - page: BuildSystemAnatomy/index.md
#     date: Tue Mar 13 19:11:51 2018 +1100
#   - page: CAmkESDifferences.md
#     date: Tue Mar 13 19:11:51 2018 +1100
# ...
# If this prebuild _data generation step gets more complicated then it should
# probably be moved to a python script.

FILE_NAME=_data/generated.yml

UPDATE_DATE:= $(shell git log -1 --format='%cd %h')
FILES:= $(shell find . -iname "*.md" | grep -ve "./README.md" | grep -ve "^./_repos/"| sed 's/.\///')
.PHONY: _data/generated.yml
_data/generated.yml:
	echo "date: $(UPDATE_DATE)" > $(FILE_NAME)
	echo timestamps: >> $(FILE_NAME) && \
	for i in $(FILES); do \
		echo "  - page: $$i" >> $(FILE_NAME) &&\
		echo "    date: `git log -1 --format='%cd %h' -- $$i`" >> $(FILE_NAME); \
	done
generate_data_files: _data/generated.yml


# Adding a git URL here and appending the directory name to REPOSITORY_LIST will
# add a rule for checking out the repository under _repos/$(REPO_NAME)
GIT_REPOS:=$(shell (cd _data/projects && for i in `ls`; do cat $$i | ../../tools/get_repos.py ; done) | sort -u)
REPOSITORY_LIST = sel4 sel4-tutorials capdl
REPOSITORIES = $(GIT_REPOS:%=_repos/%)

$(REPOSITORIES):
	mkdir -p $@
	git clone --depth=1 https://github.com/$(@:_repos/%=%) $@

_repos/tutes:
	mkdir -p $@







/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-world/hello-world.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-world/hello-world.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-world/hello-world.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-world/hello-world.md

/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/capabilities/capabilities.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/capabilities/capabilities.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/capabilities/capabilities.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/capabilities/capabilities.md


/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/untyped/untyped.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/untyped/untyped.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/untyped/untyped.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/untyped/untyped.md

/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/mapping/mapping.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/mapping/mapping.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/mapping/mapping.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/mapping/mapping.md


/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/threads/threads.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/threads/threads.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/threads/threads.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/threads/threads.md

/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/ipc/ipc.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/ipc/ipc.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/ipc/ipc.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/ipc/ipc.md


/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/notifications/notifications.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/notifications/notifications.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/notifications/notifications.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/notifications/notifications.md

/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/interrupts/interrupts.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/interrupts/interrupts.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/interrupts/interrupts.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/interrupts/interrupts.md


/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/fault-handlers/fault-handlers.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/fault-handlers/fault-handlers.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/fault-handlers/fault-handlers.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/fault-handlers/fault-handlers.md

/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/mcs/mcs.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/mcs/mcs.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/mcs/mcs.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/mcs/mcs.md


/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-1/dynamic-1.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/dynamic-1/dynamic-1.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/dynamic-1/dynamic-1.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-1/dynamic-1.md

/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-2/dynamic-2.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/dynamic-2/dynamic-2.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/dynamic-2/dynamic-2.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-2/dynamic-2.md


/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-3/dynamic-3.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/dynamic-3/dynamic-3.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/dynamic-3/dynamic-3.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-3/dynamic-3.md

/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-4/dynamic-4.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/dynamic-4/dynamic-4.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/dynamic-4/dynamic-4.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-4/dynamic-4.md


/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-0/hello-camkes-0.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-0/hello-camkes-0.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-0/hello-camkes-0.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-0/hello-camkes-0.md

/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-1/hello-camkes-1.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-1/hello-camkes-1.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-1/hello-camkes-1.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-1/hello-camkes-1.md


/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-2/hello-camkes-2.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-2/hello-camkes-2.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-2/hello-camkes-2.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-2/hello-camkes-2.md

/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-timer/hello-camkes-timer.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-timer/hello-camkes-timer.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-timer/hello-camkes-timer.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-timer/hello-camkes-timer.md


/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-vm-crossvm/hello-camkes-vm-crossvm.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-vm-crossvm/hello-camkes-vm-crossvm.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-vm-crossvm/hello-camkes-vm-crossvm.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-vm-crossvm/hello-camkes-vm-crossvm.md

/Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-vm-linux/hello-camkes-vm-linux.md: /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-vm-linux/hello-camkes-vm-linux.md
	cp /Users/birgitbrecknell/seL4-Foundation/tutorials/tutorials/hello-camkes-vm-linux/hello-camkes-vm-linux.md /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-vm-linux/hello-camkes-vm-linux.md


all: /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-world/hello-world.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/mapping/mapping.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/capabilities/capabilities.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/mapping/mapping.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/threads/threads.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/ipc/ipc.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/notifications/notifications.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/interrupts/interrupts.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/fault-handlers/fault-handlers.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/mcs/mcs.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-1/dynamic-1.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-2/dynamic-2.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-3/dynamic-3.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/dynamic-4/dynamic-4.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-0/hello-camkes-0.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-1/hello-camkes-1.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-2/hello-camkes-2.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/hello-camkes-timer/hello-camkes-timer.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/camkes-vm-crossvm/camkes-vm-crossvm.md \
    /Users/birgitbrecknell/seL4-Foundation/docs/_repos/sel4proj/sel4-tutorials/tutorials/camkes-vm-linux/camkes-vm-linux.md











_repos/tutes/%.md: _repos/sel4proj/sel4-tutorials/tutorials/% _repos/tutes
	PYTHONPATH=_repos/sel4/capdl/python-capdl-tool _repos/sel4proj/sel4-tutorials/template.py --docsite --out-dir _repos/tutes --tut-file $</$(@F)

TUTORIALS:= $(filter-out index.md overview.md setting-up.md,$(notdir $(wildcard Tutorials/seL4Kernel/*.md Tutorials/CAmkES/*.md Tutorials/DynamicLibraries/*.md Tutorials/MCS/*.md)))
tutorials: ${TUTORIALS:%=_repos/tutes/%}

_generate_api_pages: $(REPOSITORIES)
	$(MAKE) markdown -C _repos/sel4/sel4/manual

generate_libsel4vm_api: $(REPOSITORIES)
	mkdir -p projects/virtualization/docs/api && \
		for i in `ls _repos/sel4proj/sel4_projects_libs/libsel4vm/docs/libsel4vm_*`; \
		do \
			tools/gen_markdown_api_doc.py -f $$i -o projects/virtualization/docs/api/`basename $$i`; \
		done;

generate_libsel4vmmplatsupport_api: $(REPOSITORIES)
	mkdir -p projects/virtualization/docs/api && \
		for i in `ls _repos/sel4proj/sel4_projects_libs/libsel4vmmplatsupport/docs/libsel4vmmplatsupport_*`; \
		do \
			tools/gen_markdown_api_doc.py -f $$i -o projects/virtualization/docs/api/`basename $$i`; \
		done;

generate_api: _generate_api_pages generate_libsel4vm_api generate_libsel4vmmplatsupport_api

# Rules for local serving of the site using jekyll.
# Supports docker or running using local environment.
# The _production versions run with JEKYLL_ENV=production which will show additional content.
# The _production versions require `generate_data_files` to have been run separately.
JEKYLL_ENV:=development
DOCKER_IMG:=docs_builder
docker_serve: docker_build
	docker run -p 4000:4000 -v $(PWD):/docs -w /docs -it $(DOCKER_IMG) bash -c 'make serve JEKYLL_ENV=$(JEKYLL_ENV)'

docker_build:
	docker build -t $(DOCKER_IMG) tools/

# --host 0.0.0.0 serves on all interfaces, so that docker can export
# the connection; also works locally
serve: build
	JEKYLL_ENV=$(JEKYLL_ENV) bundle exec jekyll serve --host 0.0.0.0

build: generate_api ruby_deps $(REPOSITORIES)
	$(MAKE) tutorials
ifeq ($(JEKYLL_ENV),production)
	$(MAKE) generate_data_files
endif
	JEKYLL_ENV=$(JEKYLL_ENV) bundle exec jekyll build


clean:
	rm -rf _site
	rm -rf _repos
	rm -rf _data/generated.yml
	rm -rf .sass-cache/
# Check conformance for Web Content Accessibility Guidelines (WCAG) 2.0, AA
# This relies on Automated Accessibility Testing Tool (AATT) (https://github.com/paypal/AATT)
# to be running and listening on http://localhose:3000
# The resulting conformance_results.xml file can be viewed with `make check_conformance_errors` or using a junit xml viewer
check_conformance: build
	find _site -iname "*.html"| sed "s/_site.//" | python tools/testWCAG.py > conformance_results.xml

check_conformance_errors: conformance_results.xml
	grep -B1 'type="failure"' conformance_results.xml || true

LIQUID_CUSTOM_TAGS := continue

LIQUID_LINTER_CMDLINE := liquid-linter $(LIQUID_CUSTOM_TAGS:%=--custom-tag %)

# Liquid syntax linting check.
# If it is complaining about unknown custom tags -> add them to the list above.
# Requires `liquid-linter` to be installed.
# git ls-files won't list any files that are untracked
check_liquid_syntax:
	git ls-files "*.html" | xargs $(LIQUID_LINTER_CMDLINE)
	git ls-files "*.md" | xargs $(LIQUID_LINTER_CMDLINE)

# Output html checking using tidy.
# Any warnings or errors will be printed to stdout
# Requires `tidy` to be installed.
check_html_output: build
	find _site/ -iname "*.html"| xargs -l tidy -q --drop-empty-elements n -e
