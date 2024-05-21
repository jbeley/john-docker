include make_env

NS ?= jbeley
VERSION ?= latest

IMAGE_NAME ?= john
CONTAINER_NAME ?= john
CONTAINER_INSTANCE ?= default
VOLUMES=-v ~/Projects/:/data:cached -v /tmp:/output:cached
.PHONY: build push shell run start stop rm release

build: Dockerfile
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

hub-build: Dockerfile
	curl -H "Content-Type: application/json" --data '{"build": true}' -X POST ${hub_url}

git-push:
	git commit && \
		git push

push:
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)

shell:
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION) /bin/bash

shell-root:
	docker run -u root --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION) /bin/bash

run:
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)

start:
	docker run -d --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)


stop:
	docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

rm:
	docker rm $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

release: build
	make push -e VERSION=$(VERSION)

test: john


john:
	docker run --rm ${VOLUMES} ${NS}/${IMAGE_NAME}:${VERSION} pinfo.py \
		--output_format json \
		-w /output/log2timeline/WinXP2-pinfo.json  \
		/output/log2timeline/WinXP2.john

default: build
