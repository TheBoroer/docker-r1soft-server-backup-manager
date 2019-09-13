#!/bin/bash

# Create log file if it doesn't exist yet
touch /usr/sbin/r1soft/log/server.log

# Check if required variables are set
: ${CDP_USERNAME:?"CDP_USERNAME needs to be set & non-empty."}
: ${CDP_PASSWORD:?"CDP_PASSWORD needs to be set & non-empty."}
: ${CDP_HTTP_PORT:?"CDP_HTTP_PORT needs to be set & non-empty."}
: ${CDP_HTTPS_PORT:?"CDP_HTTPS_PORT needs to be set & non-empty."}

# Build up array of arguments...
args=()
[[ ! -z "$CDP_USERNAME" ]] && args+=( "--user ${CDP_USERNAME}" )
[[ ! -z "$CDP_PASSWORD" ]] && args+=( "--pass ${CDP_PASSWORD}" )
[[ ! -z "$CDP_HTTP_PORT" ]] && args+=( "--http-port ${CDP_HTTP_PORT}" )
[[ ! -z "$CDP_HTTPS_PORT" ]] && args+=( "--https-port ${CDP_HTTPS_PORT}" )
[[ ! -z "$CDP_MAX_MEM" ]] && args+=( "--set-max-mem ${CDP_MAX_MEM}" )



# Check if we need to copy the initial data, conf, log directory data 
# (new attached volume directories are blank and SBM fails to start without initial data)

# Check DATA directory, initialize if empty
if [ "$(ls -A /usr/sbin/r1soft/data)" ]; then
  echo "DATA: OK"
else
  echo "DATA: empty directory found. Initializing."
  yes | cp -avrf /usr/sbin/r1soft/data-init /usr/sbin/r1soft/data
fi

# Check CONF directory, initialize if empty
if [ "$(ls -A /usr/sbin/r1soft/conf)" ]; then
  echo "CONF: OK"
else
  echo "CONF: empty directory found. Initializing."
  yes | cp -avrf /usr/sbin/r1soft/conf-init /usr/sbin/r1soft/conf
fi

# Check LOG directory, initialize if empty
if [ "$(ls -A /usr/sbin/r1soft/log)" ]; then
  echo "LOG: OK"
else
  echo "LOG: empty directory found. Initializing."
  yes | cp -avrf /usr/sbin/r1soft/log-init /usr/sbin/r1soft/log
fi



# Run setup
serverbackup-setup ${args[@]}

# Run Server and stream logs to docker console
/usr/sbin/r1soft/service-scripts/server-service start \
  && tail -f /usr/sbin/r1soft/log/server.log \
  || /usr/sbin/r1soft/log/server.log
# ^ or if server start command fails, output server.log and then quit (easier troubleshooting). 