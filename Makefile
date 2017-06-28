NAME = alinmear/docker-dhcpd:testing

all: build-no-cache run tests clean
all-fast: build run tests clean

build-no-cache:
	docker build --no-cache -t $(NAME) .

build:
	docker build -t $(NAME) .

run:
	docker run -d --name dhcpd \
	-v "`pwd`/test/config":/tmp/docker-dhcpd \
	--net=host \
	-h dhcpd.mydomain.loc -t $(NAME)

	sleep 15

	docker run -d --name dhcpd-without-config \
	--net=host \
	-h dhcpd.mydomain.loc -t $(NAME)

	sleep 15

tests:
	./test/bats/bin/bats test/tests.bats

clean:
	-docker rm -f \
	dhcpd \
	dhcpd-without-config
