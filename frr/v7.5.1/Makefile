IMG=yykzm/frr:v7.5.1
build:
	docker build -t $(IMG) .
push:
	docker push $(IMG)
all: build push
run:
	docker run --rm -it --privileged $(IMG) bash
