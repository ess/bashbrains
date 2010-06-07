#!/bin/bash - 
#===============================================================================
#
#          FILE:  locknload.sh
# 
#   DESCRIPTION:  
# 
#  REQUIREMENTS:  brians-core, brains-file, brains-string
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Ess (ess), pooster@gmail.com
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

source 'file'
source 'string'

LOCKNLOAD_STORE=${LOCKNLOAD_STORE:-"/var/lock/locknload"}

get_lockfile() {
  defined "${1}" || die "get_lockfile - No task name given."

  locknload_init
  echo "${LOCKNLOAD_STORE}/locknload-${1}"
}

lockfile_exists() {
  defined "${1}" || die "lockfile_exists - No task name given."

  locknload_init
  local lockFile="$( get_lockfile "${1}" )"
  exists "${lockFile}" && is_file "${lockFile}"
}

lockfile_pid() {
  defined "${1}" || die "lockfile_pid - No task name given."

  locknload_init
  local pid=""
  lockfile_exists "${1}" && read pid < "$( get_lockfile "${1}" )"

  defined "${pid}" || pid=-1

  strip_whitespace "${pid}"
}

my_pid() {
  strip_whitespace "$$"
}

create_lockfile() {
  defined "${1}" || die "create_lockfile - No task name given."

  locknload_init
  local myPid="${2:-$( my_pid )}"
  echo "${myPid}" > "$( get_lockfile "${1}" )"
}

remove_lockfile() {
  defined "${1}" || die "remove_lockfile - No task name given."

  locknload_init
  rm -f "$( get_lockfile "${1}" )"
}

process_running() {
  defined "${1}" || die "process_running - No task name given."

  locknload_init
  is_directory "/proc/$( lockfile_pid "${1}" )"
}

should_run() {
  defined "${1}" || die "should_run - No task name given."

  locknload_init
  process_running "${1}" && return 1
  remove_lockfile "${1}" && return 0
}

locknload_init() {
  defined "${1}" && LOCKNLOAD_STORE="${1}"
  create_dir "${LOCKNLOAD_STORE}"
}

BRAINS_MODULE_LOCKNLOAD=1

