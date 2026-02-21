#!/bin/bash
# get weather from https://open-meteo.com/

TEMPFILE="/tmp/weather92ujrifjw2ijt.json"

code=$(
  curl -s -w "%{http_code}" -o "${TEMPFILE}" \
    "https://api.open-meteo.com/v1/forecast?latitude=53.369792&longitude=-1.474461&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m"
)

if [[ "${code}" =~ 2.. ]]; then
  msg="CURRENT OUTDOOR\nTEMPERATURE\n     "$(cat "${TEMPFILE}" | jq '.hourly.temperature_2m[0]')"⁰C"
else
  msg="temp:\ncode was not 200!"
fi

jq -cn --argjson msg "\"${msg}\"" '{
  text: $msg,
  text_wrap: false,
  flash: false,
  invert: false,
  horizontal_align: 0,
  vertical_align: 0
}'

