#!/bin/bash

################
#
# created by schiller
#
################

set -e
set -x

CURRENT_WORK_DIR=`echo ${0%/*}`

if [ -d ${CURRENT_WORK_DIR} ];then
   cd ${CURRENT_WORK_DIR}
fi

SCRIPT_PATH=`pwd`
cd "${SCRIPT_PATH}"

npm_run()
{
  cd node_modules/react-native
  npm run start
}

npm_run
