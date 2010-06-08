#!/bin/bash - 
#===============================================================================
#
#          FILE:  core.sh
# 
#   DESCRIPTION:  
# 
#  REQUIREMENTS:  ---
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

#-------------------------------------------------------------------------------
#  Setup
#-------------------------------------------------------------------------------

[ -f '/etc/bashbrainsrc' ] && . /etc/bashbrainsrc
[ -f "${HOME}/.bashbrainsrc" ] && . "${HOME}/.bashbrainsrc"

#-------------------------------------------------------------------------------
#  Globals
#-------------------------------------------------------------------------------

BRAINS_WGET=${BRAINS_WGET:-"wget -q -t 1 --timeout=5 -O -"}
BRAINS_PREFIX=${BRAINS_PREFIX:-'/usr/local/lib/bashbrains'}
BRAINS_MODULE_DIR=${BRAINS_MODULE_DIR:-"${BRAINS_PREFIX}/brains"}
BRAINS_LIB_SEARCH_PATHS="${BRAINS_LIB_SEARCH_PATHS} ${BRAINS_MODULE_DIR} ${BRAINS_PREFIX}" 
BRAINS_SCRIPT_NAME=${BRAINS_SCRIPT_NAME:-"Unnamed Script"} # Should be overridden.
BRAINS_GZFILTER="gzip -d -f"

#-------------------------------------------------------------------------------
#  Standard Library Methods
#-------------------------------------------------------------------------------

die() {
  echo -e "${BRAINS_SCRIPT_NAME} error: ${1}" 1>&2
  ! [ "$(echo ${0} | awk -F/ '{print $NF}')" == "bash" ] && exit 255 || return 255
}

defined() {
  [ -n "${1}" ]
}

exists() {
  defined "${1}" || die "exists - No path given."
  [ -e "${1}" ]
}

is_file() {
  defined "${1}" || die "is_file - No path given."
  exists "${1}" && [ -f "${1}" ]
}

is_directory() {
  defined "${1}" || die "is_directory - No path given."
  exists "${1}" && [ -d "${1}" ]
}

source_remote() {
  defined "${1}" || die "source_remote - Remote source not given."

  local rawHttpSource=$( ${BRAINS_WGET} ${1} | ${BRAINS_GZFILTER} )
  defined "${rawHttpSource}" || die "source_remote - Could not download the remote source '${1}'"
  eval "$( echo -e "${rawHttpSource}" )" || die "source_remote - Remote source '${1}' is broken."
  unset rawHttpSource
}

#-------------------------------------------------------------------------------
#  Brains Interface Methods
#-------------------------------------------------------------------------------

register_script_name() {
  defined "${1}" || die "register_script_name - No script name given."
  BRAINS_SCRIPT_NAME="${1}"
}

register_brains_uri() {
  defined "${1}" || die 'register_brains_uri - No URI given.'
  echo "${1}" | egrep -i '^(http|ftp)://' >/dev/null 2>&1 ||
  die 'register_brains_uri - Only HTTP and FTP are supported.'
  BRAINS_URI=${1}
}

add_brains_library_path() {
  defined "${1}" || die "add_brains_library_path - No path given."
  is_directory "${1}" || die "add_brains_library_path - '${1}' does not exist or is not a directory."
  BRAINS_LIB_SEARCH_PATHS="${1} ${BRAINS_LIB_SEARCH_PATHS}"
}

#-------------------------------------------------------------------------------
#  Internal Methods
#-------------------------------------------------------------------------------

find_module_path() {
  defined "${1}" || die "find_module_path - No module given."
  local p=""
  for p in ${BRAINS_LIB_SEARCH_PATHS}
  do
  
    is_directory "${p}" && is_file "${p}/${1}.sh" && echo -n "${p}" && break
  done
}

load_brains_module() {
  [ $# -gt 0 ] || die 'load_brains_module - No module names given.'

  local brainsModule="${1}"
  if ! module_is_loaded "${brainsModule}"
  then
    local modFile=$( find_module_path "${brainsModule}")/${brainsModule}.sh
    if is_file "${modFile}" 
    then
      source "${modFile}"
    elif defined "${BRAINS_URI}"
    then
      source_remote "${BRAINS_URI}/${brainsModule}.sh"
    else
      die "load_brains_modules - Module '${1}' not found."
    fi
  fi
}

module_to_env() {
  defined "${1}" || die "module_to_env - No module name given."
  local brainsModule="${1}"
  echo "BRAINS_MODULE_$( echo "${1}" | tr a-z A-Z)"
}

module_is_loaded() {
  defined "${1}" || die "module_is_loaded - No module name given."
  local brainsModule="$( module_to_env "${1}" )"
  defined "${!brainsModule}"
}

file_from_uri() {
  echo "${1}" | awk -F/ '{print $NF}'
}

#-------------------------------------------------------------------------------
#  "Public" Methods
#-------------------------------------------------------------------------------

source() {
  if is_file "${1}"
  then
    . "${1}" && return 0 || die "'${1}' could not be sourced."
  fi

  load_brains_module "${1}"
}

#-------------------------------------------------------------------------------
#  Core Module Signature
#-------------------------------------------------------------------------------

BRAINS_MODULE_CORE=1
