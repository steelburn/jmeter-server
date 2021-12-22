JMETER_VERSION="5.4.2"
IMAGE="steelburn/jmeter-server"
build:
	bash ./prep.sh
	docker build -t ${IMAGE}:${JMETER_VERSION} -t ${IMAGE}:latest .

clean:
	rm -rf plugins/*
	rm -rf temp/*

