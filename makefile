NAME=cypress-jenkins-ci-example
VERSION=latest

test:
	./node_modules/.bin/cypress run

install:
	@rm -rf ./node_modules
	npm ci

docker-build:
	@docker build -t $(NAME) --build-arg node_env=$(NODE_ENV) -f docker/Dockerfile . 

docker-run:
	@docker run $(NAME)

docker-clean:
	@docker ps -aq | xargs docker rm -f