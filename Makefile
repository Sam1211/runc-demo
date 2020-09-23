help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: image
image:  ##  Builds a container image of the runc-demo init container
	docker build -t runc-demo-init:latest -f init-container/Dockerfile .
.PHONY: run 
run:  ##  Launches the init contianer on your local system
	docker run -d --rm --privileged --net=host --pid=host --ipc=host -v /etc/systemd/system:/etc/systemd/system -v /opt:/opt  runc-demo-init
