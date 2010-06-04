#!/bin/bash - 
#===============================================================================
#
#          FILE:  brains.sh
# 
#         USAGE:  ./brains.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Ess (ess), pooster@gmail.com
#       CREATED: 06/04/10 15:08:55 EDT
#      REVISION:  ---
#===============================================================================

[ -f '/etc/bashbrainsrc' ] && source '/etc/bashbrainsrc'
[ -f "${HOME}/.bashbrainsrc" ] && source "${HOME}/.bashbrainsrc"

BRAINS_PREFIX=${BRAINS_PREFIX:-'/usr/local/lib/bashbrains'}

case $1 in
  core)
  echo "${BRAINS_PREFIX}/core.sh"
  ;;
	*)
	echo "Usage: $( basename ${0} ) core"
	;;
esac

