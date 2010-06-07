#!/bin/bash - 
#===============================================================================
#
#          FILE:  brains.sh
# 
#         USAGE:  ./brains.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  core
#  REQUIREMENTS:  brains-core
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Ess (ess), pooster@gmail.com
#      REVISION:  ---
#===============================================================================

#-------------------------------------------------------------------------------
#  Copyright 2010 Ess
#
#  This file is part of Bash Brains.
#
#  Foobar is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Foobar is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------

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

