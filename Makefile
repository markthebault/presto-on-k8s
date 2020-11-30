build:
	@sh build_docker_images.sh

deploy:
	$(MAKE) -C ./kubernetes deploy

destroy:
	$(MAKE) -C ./kubernetes destroy

test:
	$(MAKE) -C ./kubernetes run-cli