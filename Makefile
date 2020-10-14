
IMAGE=iliiillilillllliiiilllilllilll/shrtbred

GIT_COMMIT = $(shell git rev-parse --short HEAD)
GIT_TAG    = $(shell git describe --tags --abbrev=0 --exact-match 2>/dev/null)

.PHONY: docker-build
docker-build:
	docker build --tag $(IMAGE):latest --target app .
	docker build --tag $(IMAGE)-nginx:latest --target nginx .

	docker tag $(IMAGE):latest $(IMAGE):$(GIT_COMMIT)
	docker tag $(IMAGE)-nginx:latest $(IMAGE)-nginx:$(GIT_COMMIT)

ifneq ($(GIT_TAG),)
	docker tag $(IMAGE):latest $(IMAGE):$(GIT_TAG)
	docker tag $(IMAGE)-nginx:latest $(IMAGE)-nginx:$(GIT_TAG)
endif

.PHONY: docker-push
docker-push: docker-build
	docker push $(IMAGE):latest
	docker push $(IMAGE)-nginx:latest

	docker push $(IMAGE):$(GIT_COMMIT)
	docker push $(IMAGE)-nginx:$(GIT_COMMIT)

ifneq ($(GIT_TAG),)
	docker push $(IMAGE):$(GIT_TAG)
	docker push $(IMAGE)-nginx:$(GIT_TAG)
endif

.PHONY: docker-start
docker-start: docker-build
	docker-compose up -d

.PHONY: docker-stop
docker-stop:
	docker-compose down -v --remove-orphans
