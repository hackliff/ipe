#!/usr/bin/env bash

# unofficial strict mode
set -eo pipefail

# constants (
  PROGRAM="${0##*/}"

  IPE_VERSION="0.1.0"
  IPE_HOME=$HOME/.ipe
  IPE_LIB=${IPE_HOME}/lib
  IPE_PKG=${IPE_HOME}/pkg

  USER_SHELLRC=$HOME/.$(basename $SHELL)rc
  Z_URL="https://raw.githubusercontent.com/rupa/z/master/z.sh"
  TMUXP_HOME="$HOME/.tmuxp"
# )

_if_not_installed () {
  local bin="$1"
  local install_command="$2"

  command -v ${bin} > /dev/null 2>&1 || eval ${install_command}
}

check_dependencies () {
  _if_not_installed noti "brew install noti"
  _if_not_installed yosay "npm install -g yosay"
}

install_z() {
  local install_path="$1"

  # TODO replace by curl
  wget -q -O ${install_path} ${Z_URL}
}

install_autoenv() {
  local install_path="$1"

  git clone https://github.com/hackliff/autoenv ${install_path}
  echo "source ${install_path}/activate.sh" >> ${USER_SHELLRC}
}

install_tmuxp () {
  pip install -U tmuxp
  test -d ${TMUXP_HOME} || mkdir -p ${TMUXP_HOME}
  # NOTE copy a standard hack.yaml ?
}

() {
  [[ -d "$HOME/.ipe" ]]
}

main() {
  check_dependencies

  [[ -d "${IPE_HOME}" ]] || mkdir -p ${IPE_HOME}/{lib,pkg}
  [[ -f "${IPE_LIB}/z.sh" ]] || install_z ${IPE_LIB}/z.sh
  # FIXME use upstream now
  #[[ -d "${IPE_LIB}/autoenv" ]] || install_autoenv ${IPE_LIB}/autoenv

  cp ./ipe /usr/local/bin/ipe
}

# idempotent support for installation
# TODO
_is_initialized || main $@
