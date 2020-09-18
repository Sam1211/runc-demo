help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: image
image:  ##  Builds a container image of the runc-demo init container
	docker build -t runc-demo-init:latest -f init-container/Dockerfile .
.PHONY: run 
run:  ##  Launches the init contianer on your local system
	docker run -v /var/run/docker.sock:/var/run/docker.sock -v /run/containerd:/run/containerd -v /var/run/crio:/var/run/crio -v /dev:/dev -v /proc:/proc -v /usr/bin:/usr/bin -v /etc/systemd/system:/etc/systemd/system -v /opt:/opt runc-demo-init
