FROM debian:wheezy

ENV CONFIGURE_OPTS --disable-install-doc
ENV PATH /root/.rbenv/versions/2.2.0/bin:/root/.rbenv/bin:$PATH
ENV RUBYOPT W0

# Install packages for building ruby
RUN apt-get update && \
	apt-get install -y sudo build-essential vim numactl procps curl libcurl3 libcurl3-gnutls libcurl4-openssl-dev git zlib1g-dev libffi-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev && \
	apt-get clean && rm -rf /var/lib/apt/lists/* && \
	gpg --keyserver pgp.mit.edu --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
	curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" && \
	curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" && \
	gpg --verify /usr/local/bin/gosu.asc && \
	rm /usr/local/bin/gosu.asc && \
	chmod +x /usr/local/bin/gosu && \
	git clone https://github.com/sstephenson/rbenv.git /root/.rbenv && \
	git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build && \
	./root/.rbenv/plugins/ruby-build/install.sh && \
	rbenv install 2.2.0 && echo 'gem: --no-rdoc --no-ri' >> /.gemrc && \
	rbenv global 2.2.0 && gem install bundler && rbenv rehash
