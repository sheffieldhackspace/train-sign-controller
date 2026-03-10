#!/bin/bash

rawxml=$(
  curl -s --fail \
    "https://www.sheffieldhackspace.org.uk/feed.xml"
)

if [[ "${?}" != 0 ]]; then
  msg="something went wrong with CURL !"
else
  lastitem=$(
    echo "${rawxml}" | hxselect -c -s '\n' 'entry title' | head -n1 \
      | sed 's+\&amp;+\&+g' \
      | python3 -c 'import sys;from html import unescape;print(unescape(sys.stdin.read()),end="")'
  )
  msg="LAST BLOG POST\n${lastitem}"
fi

jq -cn --argjson msg "\"${msg}\"" '{
  text: $msg,
  text_size: 1,
  text_wrap: true,
  flashing: false,
  inverted: false,
  horizontal_align: "center",
  vertical_align: "middle"
}'
