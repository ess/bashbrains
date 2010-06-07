#!/bin/bash - 
#===============================================================================
#
#          FILE:  install.brains.sh
# 
#         USAGE:  ./install.brains.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Ess (ess), pooster@gmail.com
#      REVISION:  ---
#===============================================================================

PREFIX=${PREFIX:-/usr/local}
BRAINS_PREFIX=${PREFIX}/lib/bashbrains

mkdir -p ${BRAINS_PREFIX}
mkdir -p ${BRAINS_PREFIX}/brains
mkdir -p ${BRAINS_PREFIX}/site_brains

echo "BRAINS_PREFIX=${BRAINS_PREFIX}" > /etc/bashbrainsrc
chmod 644 /etc/bashbrainsrc

install -m755 brains.sh ${PREFIX}/bin/brains.sh
ln -s ${PREFIX}/bin/brains.sh ${PREFIX}/bin/brains
install -m644 lib/core.sh ${BRAINS_PREFIX}/core.sh
install -m644 lib/brains/time.sh ${BRAINS_PREFIX}/brains/time.sh
install -m644 lib/brains/string.sh ${BRAINS_PREFIX}/brains/string.sh
install -m644 lib/brains/file.sh ${BRAINS_PREFIX}/brains/file.sh
install -m644 lib/brains/locknload.sh ${BRAINS_PREFIX}/brains/locknload.sh
