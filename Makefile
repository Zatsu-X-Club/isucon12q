HOSTNAME:=$(shell hostname)
BRANCH:=master

all: build

.PHONY: deploy
deploy: checkout start

.PHONY: checkout
checkout:
	git fetch && \
	git reset --hard origin/$(BRANCH)

.PHONY: start
start:
	cd $(HOSTNAME) && ./deploy.sh

# daemon名の確認
.PHONY: list-daemon
list-daemon:
	systemctl list-unit-files --type=service

# sudo make setup で。
.PHONY: setup
setup:
	wget https://www.percona.com/downloads/percona-toolkit/2.2.17/deb/percona-toolkit_2.2.17-1.tar.gz
	tar xf percona-toolkit_2.2.17-1.tar.gz
	cd percona-toolkit-2.2.17; perl Makefile.PL && make && make install
	wget https://github.com/tkuchiki/alp/releases/download/v1.0.3/alp_linux_amd64.zip
	sudo apt-get install unzip
	unzip alp_linux_amd64.zip
	sudo mv alp /usr/local/bin/
	sudo apt-get install graphviz*
	wget https://github.com/bcicen/slackcat/releases/download/1.7.1/slackcat-1.7.1-linux-amd64 -O slackcat
	sudo mv slackcat /usr/local/bin/
	sudo chmod +x /usr/local/bin/slackcat
	slackcat --configure
	rm -rf percona-toolkit_2.2.17-1.tar.gz percona-toolkit-2.2.17 alp_linux_amd64.zip
