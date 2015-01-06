FROM debian:wheezy

# Install packages for building ruby
RUN apt-get update && apt-get install -y build-essential vim numactl curl git zlib1g-dev libffi-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev && apt-get clean && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
RUN gpg --keyserver pgp.mit.edu --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu
	
# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/versions/2.2.0/bin:/root/.rbenv/bin:$PATH
ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install 2.2.0 && echo 'gem: --no-rdoc --no-ri' >> /.gemrc && rbenv global 2.2.0 && gem install bundler && rbenv rehash
