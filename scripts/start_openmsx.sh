#!/bin/bash	

xopenmsx=`ps x | grep "openmsx " | grep -v grep`
 
if [ "${xopenmsx}" == "" ]; then
  /Applications/openMSX.app/Contents/MacOS/openmsx -script ./scripts/MSX1_DOS1.txt
else
  echo "openMSX is already running. Exiting now."
fi
