#!/bin/bash
# continuously run, and round-robin calling scripts from ./cycle/

source .env

if [[ -z "${SIGN_IP}" ]]; then
  echo "no IP set! set SIGN_IP in .env"
fi

sleep_time="${SLEEP_TIME:-90}"

i="${1:-5}"
echo "starting cycle from item ${i}, with ${sleep_time} s between items"
while true; do
  # choose file
  echo "=== executing file ${i} ===" >&2
  files=$(find cycle -name "*.sh" | sort -V)
  nfiles=$(echo "${files}" | wc -l)

  echo "  found ${nfiles} in ./cycle/" >&2
  file=$(echo "${files}" | head -n$i | tail -n1)

  echo "  executing ${file}" >&2
  json=$(eval "./${file}")
  echo "  got json: ${json}" >&2

  # send file
  curl "http://${SIGN_IP}:80/" --data "${json}"

  # increment round robin
  i=$(( 1 + ( $i % $nfiles ) ))

  if [[ ! -z "${EXIT_IMMEDIATELY}" ]]; then exit 0; fi

  sleep "${sleep_time}"
done
