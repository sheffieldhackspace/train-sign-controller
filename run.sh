#!/bin/bash
# continuously run, and round-robin calling scripts from ./cycle/

source .env

if [[ -z "${SIGN_IP}" ]]; then
  echo "no IP set! set SIGN_IP in .env"
fi

i=2
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

  sleep 5
done
