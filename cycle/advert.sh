#!/bin/bash
# show icon and "Sheffield Hackspace"
# for icon see icons/shhm.bmp in https://github.com/sheffieldhackspace/train-signs

jq -cn '{
  "text": "WRITE A SCRIPT\nFOR ME!\nsee the GitHub or\nask Adam or Alfie",
  "text_size": 1,
  "text_wrap": false,
  "flashing": false,
  "inverted": false,
  "horizontal_align": "center",
  "vertical_align": "middle"
}'
