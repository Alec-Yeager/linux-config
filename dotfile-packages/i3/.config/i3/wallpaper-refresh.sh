#!/bin/bash

pkill -f 'i3-msg -t subscribe -m '["output"]''  2>/dev/null

i3-msg -t subscribe -m '["output"]' | while read -r _; do
    ~/.fehbg
done
