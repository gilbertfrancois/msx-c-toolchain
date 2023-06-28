#!/bin/bash	
# OpenMSX Start Script
# The emulator will be started only if it's not already active


xopenmsx=`ps x | grep "openmsx " | grep -v grep`
 
if [ "${xopenmsx}" == "" ]; then
  echo "...Now Starting OpenMsx "
  /Applications/openMSX.app/Contents/MacOS/openmsx -script ./scripts/MSX2_emul_start_config.txt
else
  echo "...openMSX already running "
fi
