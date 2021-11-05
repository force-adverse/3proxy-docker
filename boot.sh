#!/bin/bash

if [[ -n ${PROXY_PARENT_HOST} && -n ${PROXY_PARENT_PORT} && -n ${PROXY_PARENT_AUTH} ]]; then
  echo "Detected parent proxy settings, adding line to config"
  SET PROXY_PARENT = "parent 1000 http ${PROXY_PARENT_HOST}:${PROXY_PARENT_PORT} ${PROXY_PARENT_AUTH/:/ }"
else
  echo "No parent proxy configuration detected"
fi

echo "Creating proxy config from environment vars"
cat <<EOF >"${PROXY_CONFIG:=/tmp/3proxy}"
pidfile /tmp/3proxy.pid
log /tmp/3proxy.log
logformat "${PROXY_LOG_FORMAT:=L%O %I %T}"
maxconn ${PROXY_MAX_CONNECTIONS:='2048'}
auth ${PROXY_AUTH:=iponly}
allow * 127.0.0.1 * *
${PROXY_PARENT:=}
proxy -p${PROXY_PORT:=5000} -i127.0.0.1 -a
EOF

cat ${PROXY_CONFIG}

exec "$@"
