#!/bin/bash - 
#===============================================================================
#
#          FILE:  time.sh
# 
#   DESCRIPTION:  
# 
#  REQUIREMENTS:  brains-core-string
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
#  Bash Brains is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Bash Brains is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Bash Brains.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------

source 'core/string'

time_now() {
  strip_whitespace "$( date +"%s" )"
}

BRAINS_MODULE_CORE_TIME=1
