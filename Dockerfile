FROM alpine:3.14.2

# Tag name: force-adverse/3proxy

# Arguments that should be added
# PROXY_EXECUTABLE_DIR=
# PROXY_INTERFACE_IP=127.0.0.1
# PROXY_MAX_CONNECTIONS=2048
# PROXY_AUTH=iponly
# PROXY_LOG_FORMAT=L%O %I %T

########
ENV THREEPROXY_VERSION=0.9.4
########

# Install 3proxy to /usr/local/bin
RUN apk add alpine-sdk && \
	export DIR=$(mktemp -d) && cd $DIR && \
	wget https://github.com/3proxy/3proxy/archive/refs/tags/${THREEPROXY_VERSION}.tar.gz && tar -xf ${THREEPROXY_VERSION}.tar.gz && mv 3proxy* 3proxy && \
	cd 3proxy && \
	make -f Makefile.Linux || true && \
	mv bin/3proxy /usr/local/bin/ && \
	cd && rm -rf $DIR && \
	apk del alpine-sdk
# outputs a 3proxy binary @ /usr/local/bin/3proxy

CMD ["3proxy"]
