#!/bin/bash
autorandr -l $(autorandr -c | sed 's/ (current)//g' | sort | dmenu -l 5) && ~/.fehbg
