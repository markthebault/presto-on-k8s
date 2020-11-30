build:
	@sh build_docker_images.sh

deploy:
	$(MAKE) -c ./deploy deploy

destroy:
	$(MAKE) -c ./deploy destroy

test:
	cd ./deploy && make run-cli