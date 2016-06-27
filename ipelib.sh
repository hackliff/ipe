#!/usr/bin/env bash
# vim: filetype=sh

# Automatic project-scope setup
#
# notes:
#   - methods starting with "__" are private, other are meant to be exposed to the developer
#
# dependencies:
#   - Env auto-(un)loading : https://github.com/hackliff/autoenv
#   - Time tracking : http://tailordev.github.io/Watson/
#   - Notification : https://github.com/variadico/noti
#   - Bash lib : https://github.com/LuRsT/hr
#   - Issue tracker : https://github.com/stephencelis/ghi

# since we need some custom tools, setup shell if necessary
#[ -n "${__SHELL_ENV_LOADED__}"   ] || source $HOME/.zshrc

## abort quietly if already setup
[ -z "${__PROJECT__}"   ] || return

# generic project management
export __PROJECT__="$(basename $PWD)"
export IPE_SHELLRC="$HOME/.$(basename $SHELL)rc"
export IPE_TMP_PATH=/tmp
export IPE_INIT_FILE_PATH=${IPE_TMP_PATH}/${__PROJECT__}-init.ipe

## user settings
export RUNTIME_VERSION="6.0.0"

ipe_printf () {
  local message="$1\n"
  autoenv_printf "$(date +%H:%M:%S) [info] ${message}"
}

_remember_init () {
  local init_filepath=${1:-${IPE_INIT_FILE_PATH}}
  test -f ${init_filepath} || touch ${init_filepath}
}

_activate_runtime () {
  local runtime_version=$1
  ipe_printf "activating project runtime ${runtime_version}"
  n ${runtime_version}
}

_once () {
  local to_run="${1}"
  local init_filepath=${IPE_INIT_FILE_PATH}
  test -f ${init_filepath} || eval ${to_run}
}

_reset () {
  local init_filepath=${1:-${IPE_INIT_FILE_PATH}}

  unset __PROJECT__
  unset IPE_RUNTIME_VERSION
  unset IPE_INIT_FILE_PATH
  test -f ${init_filepath} && rm -f ${init_filepath}
}

# --------------------------- public methods

track_issues () {
  ipe_printf "checking for open github issues"
  ghi --no-pager list --state=open --sort=created
}

ipe_unenv_exec () {
  ipe_printf "reseting project ${__PROJECT__} setup, bye!"
  _reset
}

ipe_env_exec() {
  _once "yosay 'Hi there, welcome back to your ${__PROJECT__} project! Let me activate your environment for you...'"

  _activate_runtime "${RUNTIME_VERSION}"
  _once "test -d ./.git && track_issues"

  _remember_init
}

ipe_main () {
  hr "~"
  echo

  ipe_env_exec $@

  echo
  hr "~"
  echo
}
