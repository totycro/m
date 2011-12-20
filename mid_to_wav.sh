#!/bin/sh
INFILE="$1"
timidity "$INFILE" -Ow -o "${INFILE}.wav"
