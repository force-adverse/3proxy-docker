FROM alpine:3.14.2

# Tag name: force-adverse/3proxy

ENV PROXY_EXECUTABLE_DIR "/usr/local/bin/"
ENV PROXY_CONFIG "/home/proxy/3proxy.conf"

# Install 3proxy to /usr/local/bin
RUN apk add alpine-sdk jq bash && \
	export BUILD_DIR=$(mktemp -d) && \
  cd "${BUILD_DIR}" && \
  export PROXY_VERSION=$(curl -fsSL "https://api.github.com/repos/z3APA3A/3proxy/releases/latest" | jq -r 'first(.tag_name)') && \
  curl -fsSL -o "${PROXY_VERSION}.tar.gz" "https://github.com/3proxy/3proxy/archive/refs/tags/${PROXY_VERSION}.tar.gz" && \
  tar -xf "${PROXY_VERSION}.tar.gz" && mv 3proxy* 3proxy && \
	cd 3proxy && \
	make -f Makefile.Linux || true && \
	mv bin/3proxy "${PROXY_EXECUTABLE_DIR}" && \
	cd && rm -rf "${BUILD_DIR}" && \
	apk del alpine-sdk && \
  addgroup -S proxy && adduser -S proxy -G proxy

# Outputs a 3proxy binary @ /usr/local/bin/3proxy and creates application user

# Switch to application user
USER proxy
SHELL ["/bin/bash"]
WORKDIR "/home/proxy"

# Copy boot script which generates config file
COPY --chown=proxy:root [ "boot.sh", "./" ]

# Set boot script as entrypoint and 3proxy as default command
ENTRYPOINT [ "/home/proxy/boot.sh" ]
CMD [ "${PROXY_EXECUTABLE_DIR}/3proxy", "${PROXY_CONFIG}" ]

# Publish container
LABEL org.opencontainers.image.source="https://github.com/force-adverse/3proxy"
