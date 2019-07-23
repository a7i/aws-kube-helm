build:
	docker build . --no-cache -t amiralavi/aws-kube-helm:latest
	docker tag amiralavi/aws-kube-helm:latest amiralavi/aws-kube-helm:1.3

push:
	docker push amiralavi/aws-kube-helm:latest
	docker push amiralavi/aws-kube-helm:1.3