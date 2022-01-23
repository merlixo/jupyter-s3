
# jupyter-s3

Dockerfile for JupyterLab with:
 - Python, Scala, R, Spark
 - AWS S3 integration


## Build and run

Build image:

	make build TAG=my_tag


Start Jupyter-s3 container:

	make start AWS_Profile=my_profile


## Play

Connect to http://localhost:8888 and have fun !



## Run directly with Dockerhub image

The images from this repo are available on Dockerhub: merlixo/jupyter-s3.
https://hub.docker.com/repository/docker/merlixo/jupyter-s3/general

	docker run -d --rm -p 8888:8888 -v ~/.aws:/home/jovyan/.aws:ro \
		-e JUPYTER_TOKEN="" -e GRANT_SUDO=yes \
		-e AWS_PROFILE=$AWS_PROFILE \
		--name jupyter-s3 merlixo/jupyter-s3:latest





