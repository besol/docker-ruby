FROM alpine:3.2

RUN apk add --update git openssh-client libffi-dev make gcc g++ libxml2-dev libxslt-dev openssl-dev ruby-dev ruby-bundler ca-certificates bash vim && \
	echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc" && \
	rm /var/cache/apk/* && \
        rm -rf /usr/share/ri

