#!/bin/bash
# get weather from https://open-meteo.com/

TEMPFILE="/tmp/weather92ujrifjw2ijt.json"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

code=$(
  curl -s -w "%{http_code}" -o "${TEMPFILE}" \
    "https://api.open-meteo.com/v1/forecast?latitude=53.369792&longitude=-1.474461&current=weather_code,is_day"
)

if [[ "${code}" =~ 2.. ]]; then
  is_day=$(cat "${TEMPFILE}" | jq '.current.is_day')
  wc=$(cat "${TEMPFILE}" | jq '.current.weather_code')
  # wc=1
  weather_desc=$(
    cat "${SCRIPT_DIR}/weather.json" \
      | jq -r --argjson wc "${wc}" --argjson is_day "${is_day}" \
        '."\($wc)" | (if $is_day then .day else .night end) | .description'
  )
  weather_img_url=$(
    cat "${SCRIPT_DIR}/weather.json" \
      | jq -r --argjson wc "${wc}" --argjson is_day "${is_day}" \
        '."\($wc)" | (if $is_day then .day else .night end) | .image'
  )
  # download image
  curl -s "${weather_img_url}" \
    | convert /dev/stdin -resize 24x24 -alpha off -threshold 25% /tmp/img.bmp
  image_base64=$(python3 icons/image2bytes.py /tmp/img.bmp)

  msg="CURRENT\nWEATHER\n${weather_desc}"
else
  msg="temp:\ncode was not 200!"
fi

jq -cn \
  --argjson msg "\"${msg}\"" \
  --argjson imageb64 "\"${image_base64}\"" \
  '{
  text: $msg,
  text_size: 1,
  text_wrap: false,
  flashing: false,
  inverted: false,
  horizontal_align: "left",
  vertical_align: "middle",
  image: $imageb64,
  image_width: 24,
  image_height: 24
}'
