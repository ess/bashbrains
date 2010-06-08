#!/bin/bash - 
#===============================================================================
#
#          FILE:  file.sh
# 
#   DESCRIPTION:  
# 
#  REQUIREMENTS:  brains-core, brains-core-string, brains-core-time, coreutils
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

source 'core/string'
source 'core/time'

file_age() {
  local currentTime="$( time_now )"
  local fileCtime="$( strip_whitespace "$( stat -c "%Z" "${1}" )" )"

  strip_whitespace "$( expr "${currentTime}" - "${fileCtime}" )"
}

file_size() {
  strip_whitespace "$( stat -c "%s" "${1}" )"
}

is_readable() {
  [ -r "${1}" ]
}

is_writable() {
  [ -w "${1}" ]
}

is_executable() {
  [ -x "${1}" ]
}

create_dir() {
  defined "${1}" || die "create_dir - No path given."

  mkdir -p "${1}" || die "create_dir - Could not create '${1}'"
}

BRAINS_MODULE_CORE_FILE=1

