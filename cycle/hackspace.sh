#!/bin/bash
# show icon and "Sheffield Hackspace"
# for icon see icons/shhm.bmp in https://github.com/sheffieldhackspace/train-signs

jq -cn '{
  text: ".\n SHEFFIELD\n HACKSPACE",
  text_wrap: false,
  flash: false,
  invert: false,
  horizontal_align: -1,
  vertical_align: 1,
  image: "ABgAAZmAAf+AGf+YH//4DgAwDv/wfH/+fv+uP/UEP1VU8VF39xV/MVX8PV/8cf++f/8eD/+wDgAwH//4Gf+YAf+AAZmAABgA",
  image_width: 24,
  image_height: 24
}'
