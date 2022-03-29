IMG=yykzm/frr:v8.2.2
build:
	docker build -t $(IMG) .
push:
	docker push $(IMG)
all: build push
run:
	docker run --rm -it --privileged $(IMG) bash
