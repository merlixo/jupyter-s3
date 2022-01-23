
TAG = latest
AWS_PROFILE = default
AWS_ACCESS_KEY_ID = $(shell aws --profile $(AWS_PROFILE) configure get aws_access_key_id)
AWS_SECRET_ACCESS_KEY = $(shell aws --profile $(AWS_PROFILE) configure get aws_secret_access_key)
AWS_DEFAULT_REGION = $(shell aws --profile $(AWS_PROFILE) configure get region)

# Build with default authentication provider (ProfileCredentialsProvider)
build:
	docker build -t jupyter-s3:$(TAG) .

# Build example setting the authentication provider to EnvironmentVariableCredentialsProvider
build-with-args:
	docker build \
		--build-arg authentication_provider=com.amazonaws.auth.EnvironmentVariableCredentialsProvider \
		-t jupyter-s3:$(TAG) .

# Provide env variables for both EnvironmentVariableCredentialsProvider and ProfileCredentialsProvider
start:
	docker run -d --rm -p 8888:8888 -p 4040:4040 -p 4041:4041 \
		-v ~/.aws:/home/jovyan/.aws:ro -v ~/data/jupyter:/home/jovyan -e JUPYTER_TOKEN="" -e GRANT_SUDO=yes \
		-e AWS_PROFILE=$(AWS_PROFILE) \
		-e AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		-e AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		-e AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) \
		--name jupyter-s3 jupyter-s3:latest

stop:
	docker stop jupyter-s3

restart: stop start