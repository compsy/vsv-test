
.DEFAULT_GOAL := deploy

login:
	heroku container:login

deploy:
	docker build -t vsv-test .
	heroku container:push web -a vsv-test
	heroku container:release web -a vsv-test
