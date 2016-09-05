#!/bin/bash
# $Id: colors.sh 342078e6fbd5 2014/10/31 22:58:34 dave $
# outputs color information for mutt depending on whether we're in a standard or 256 color term

if [[ "$(tput colors)" =~ "256" ]]; then
	\cat ~/.mutt/colors-256
else
	\cat ~/.mutt/colors
fi
