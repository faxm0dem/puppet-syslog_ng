PLATFORMS=docker/ubuntu-12.04/ruby-1.8.7 \
		 docker/ubuntu-14.04/ruby-1.9.3

all: build

build: .gemfile fig.yml
	git archive -o module.tar.gz HEAD
	for dir in $(PLATFORMS); do \
		cp -u .gemfile $$dir/Gemfile; \
		cp -u module.tar.gz $$dir/module.tar.gz; \
	done
	fig build

check:
	fig up -d
	fig ps

ps:
	fig ps

logs:
	fig logs

clean: 
	fig rm --force
	rm -f docker/ubuntu-12.04/ruby-1.8.7/Gemfile
	rm -f docker/ubuntu-12.04/ruby-1.8.7/module.tar.gz
	rm -f docker/ubuntu-14.04/ruby-1.9.3/Gemfile
	rm -f docker/ubuntu-14.04/ruby-1.9.3/module.tar.gz

.PHONY: all check ps clean logs
