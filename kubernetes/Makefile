K8S_NS=mth

deploy:
	@echo "make sure the file '02-metastore/s3-secret.yaml.secret' is created from aws keys, example in '02-metastore/s3-secret.yaml.secret.example'"
	kubectl -n $(K8S_NS) apply -f ./01-database
	kubectl -n $(K8S_NS) wait --for=condition=complete --timeout=300s job/hive-initschema

	kubectl -n $(K8S_NS) apply -f ./02-metastore/s3-secret.yaml.secret
	kubectl -n $(K8S_NS) apply -f ./02-metastore/

	kubectl -n $(K8S_NS) apply -f ./03-presto/

destroy:
	kubectl -n $(K8S_NS) delete -f ./03-presto/
	kubectl -n $(K8S_NS) delete -f ./02-metastore/
	kubectl -n $(K8S_NS) delete -f ./02-metastore/s3-secret.yaml.secret
	kubectl -n $(K8S_NS) delete -f ./01-database

run-cli:
	kubectl -n $(K8S_NS) exec -it pod/presto-cli -- /opt/presto-cli --server presto:8080 --catalog hive --schema default