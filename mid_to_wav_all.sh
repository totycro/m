#!/bin/sh
find . -iname \*.mid -exec ./mid_to_wav.sh "{}" \;
