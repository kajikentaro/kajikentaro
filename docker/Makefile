DOCKERFILE=atcoder.Dockerfile
IMAGE_NAME=kajindowsxp/atcoder

rebuild:
	docker build --progress=plain -f $(DOCKERFILE) -t $(IMAGE_NAME) .

run:
	docker run --rm -it $(IMAGE_NAME) bash

push:
	docker push $(IMAGE_NAME)

compose:
	docker compose up atcoder --force-recreate
