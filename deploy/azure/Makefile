K8S_NS=mth

deploy:
	kubectl -n $(K8S_NS) apply -f ../../kubernetes/02-metastore/s3-secret.yaml.secret
	kubectl -n $(K8S_NS) apply -f ../../kubernetes/02-metastore/azuresa-secret.yaml.secret
	helmfile -n $(K8S_NS) apply

destroy:
	helmfile -n $(K8S_NS) delete
	kubectl -n $(K8S_NS) delete -f ../../kubernetes/02-metastore/s3-secret.yaml.secret
	kubectl -n $(K8S_NS) delete -f ../../kubernetes/02-metastore/azuresa-secret.yaml.secret