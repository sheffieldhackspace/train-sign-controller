#!/bin/bash
# show icon and "Sheffield Hackspace"
# for icon see icons/shhm.bmp in https://github.com/sheffieldhackspace/train-signs

EMF_START_DATE="2026-07-16"

now=$(date '+%s')
then=$(date --date="${EMF_START_DATE}" '+%s')

secs_until=$(( $then - $now ))
days_until=$(( $secs_until / (24 * 3600) ))


days_until_text=$(
    echo "${days_until}" \
      | sed -E '
        s+1(..)$+one hundred \1+
        s+2(..)$+two hundred \1+;
        s+3(..)$+three hundred \1+;
        s+0(.)$+and \1+;
        s+1(.)$+and \1+;
        s+2(.)$+and twenty \1+;
        s+3(.)$+and thirty \1+;
        s+4(.)$+and fourty \1+;
        s+5(.)$+and fify \1+;
        s+6(.)$+and sixty \1+;
        s+7(.)$+and seventy \1+;
        s+8(.)$+and eighty \1+;
        s+9(.)$+and ninety \1+;
        s+0$++;
        s+1$+one+;
        s+2$+two+;
        s+3$+three+;
        s+4$+four+;
        s+5$+five+;
        s+6$+six+;
        s+7$+seven+;
        s+8$+eight+;
        s+9$+nine+;
        s+10$+ten+;
        s+11$+eleven+;
        s+12$+twelve+;
        s+13$+thirteen+;
        s+14$+fourteen+;
        s+15$+fifteen+;
        s+16$+sixteen+;
        s+17$+seventeen+;
        s+18$+eighteen+;
        s+19$+nineteen+;
      '
)

jq -cn --arg d "${days_until}"  '{
  "text": " \($d)      \nDAYS UNTIL\n EMF CAMP",
  "text_size": 1,
  "text_wrap": false,
  "flashing": false,
  "inverted": true,
  "horizontal_align": "right",
  "vertical_align": "middle",
  "image": "AAfgAAA//AAAeB4AAOAHAAGAAYADAADABwAA4AYAAGAGAABgDAAAMAwPDjAMH54wDHn4MAxw8DAMAAAwBgAAYAYAAGAHAADgAwAAwAGAAYAA4AcAAHgeAAA//AAAB+AA",
  image_width: 32,
  image_height: 24
}'
