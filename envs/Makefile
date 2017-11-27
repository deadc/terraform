SUBDIRS = $(shell ls -d */)
ACTION = plan

all:
	for dir in $(SUBDIRS) ; do \
	make -C  $$dir -e ACTION=${ACTION} ; \
	done
