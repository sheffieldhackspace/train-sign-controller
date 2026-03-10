#!/bin/bash
# show icon and "Sheffield Hackspace"
# for icon see icons/shhm.bmp in https://github.com/sheffieldhackspace/train-signs

jq -cn '{
  text: "SHEFFIELD\nHACKSPACE",
  text_size: 1,
  text_wrap: false,
  flashing: false,
  inverted: false,
  horizontal_align: "left",
  vertical_align: "middle",
  image: "AAGAAAAZmAAAH/gAAZ/5gAH//4AA4AMAAO//AAfH/+AH7/rgA/9QQAP1VUAPFRdwD3FX8AMVX8AD1f/ABx/74Af/8eAA//sAAOADAAH//4ABn/mAAB/4AAAZmAAAAYAA",
  image_width: 32,
  image_height: 24
}'
