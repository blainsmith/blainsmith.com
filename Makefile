serve:
	hugo server

build:
	hugo

deploy: build
	surge --project=./public
