#!/bin/bash

rawhtml=$(
  curl -s --fail \
    "https://wiki.sheffieldhackspace.org.uk/members/membership"
)

if [[ "${?}" != 0 ]]; then
  msg="something went wrong with CURL !"
else
  html=$(
    echo "${rawhtml}" | hxnormalize -x -l 240
  )
  date=$(echo "${html}"| hxselect -c '.row1 .col0' | sed 's+^ *++')
  members=$(echo "${html}"| hxselect -c '.row1 .col1' | sed 's+^ *++')
  keyholders=$(echo "${html}"| hxselect -c '.row1 .col2' | sed 's+^ *++')

  msg="MEMBERSHIP ON\n${date}\n${members} MEMBERS\n${keyholders} KEYHOLDERS"
fi

jq -cn --argjson msg "\"${msg}\"" '{
  text: $msg,
  text_size: 1,
  text_wrap: false,
  flashing: false,
  inverted: false,
  horizontal_align: "center",
  vertical_align: "middle"
}'
