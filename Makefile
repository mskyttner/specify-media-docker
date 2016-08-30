PWD := $(shell pwd)

all: build up test
.PHONY: all

build:
	docker build --tag dina/media:latest .

debug:
	docker run --rm -it --env-file=.env \
		-p 8080:8080 -v $(PWD)/data:/home/specify/attachments \
		dina/media sh

up:
	docker run --name media -d --env-file=.env \
		-p 8080:8080 -v $(PWD)/data:/home/specify/attachments \
		dina/media

test:
	firefox http://localhost:8080/web_asset_store.xml & 

cfg:
	@echo "Use these settings in Specify 6"
	@echo "USE_GLOBAL_PREFS = true"
	@echo "attachment.url = http://localhost:8080/web_asset_store.xml"
	@echo "attachment.use_path = false"
	@echo "attachment.key = {use value below!}"
	@cat settings.py | grep "KEY ="

clean:
	docker stop media
	docker rm media
