#!/bin/bash

thisscript="$0"
while [ -L "$thisscript" ]; do
        thisscript="`readlink "$thisscript"`"
done

dirname=`dirname "$thisscript"`
if [ $dirname = "." ]; then
        dirname="$PWD"
fi

appname="`basename "$thisscript" | sed 's,\.sh$,,'`"

PARAMETERS=( ${@} )

if [ -f ${PARAMETERS[0]} ]
then
  if [ -f `pwd`"/${PARAMETERS[0]}" ]
  then
    echo "adding pwd to scene_name"
    PARAMETERS[0]=`pwd`"/${PARAMETERS[0]}"
  fi
fi

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$dirname
export LD_LIBRARY_PATH
"$dirname/$appname" "${PARAMETERS[@]}"
