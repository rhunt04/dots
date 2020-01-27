# rjh .bash_functions

# print messages neatly when called from within a bash function
log() {
  # FUNCNAME[0] would be "log", so go for the caller function
  echo "[${FUNCNAME[1]}] $1"
}

# make a file or directory into a tarball
tarball() {

  [ $# -eq 0 ] && log "no arguments supplied." && return 1;

  # remove trailing slash (possible if directory fed in)
  for fdir in "${@%/}"; do

    # fdir is a directory or file?
    [[ ! -f "$fdir" ]] && [[ ! -d "$fdir" ]] &&
    log "\"$fdir\" not file or directory." && continue;

    tar -czvf "${fdir}.tgz" "$fdir";

  done

  log "done tarring." && return 0;
}

# extract a variety of archives 
extract() {

  [ $# -eq 0 ] && log "no arguments supplied." && return 1;
  [ ! -f "$1" ] && log "file \"$1\" doesn't exist." && return 1;

  log "preparing $1."
  case $1 in
    *.tgz | *.tar.gz)
               tar xvzf "$1" 2>&1 ;;
    *.tbz | *.tbz2 | *.tar.bz2)
               tar xvjf "$1" 2>&1 ;;
    *.gz)      gunzip   "$1" 2>&1 ;;
    *.tar)     tar xvf  "$1" 2>&1 ;;
    *.bz2)     bunzip2  "$1" 2>&1 ;;
    *.rar)     unrar x  "$1" 2>&1 ;;
    *.zip)     unzip    "$1" 2>&1 ;;
    *.7z)      7z x     "$1" 2>&1 ;;
    *.xz)      unxz     "$1" 2>&1 ;;
    *.lzma)    unlmza   "$1" 2>&1 ;;
    *) log "file \"$1\" is not valid." && return 1;
  esac
  log "done extracting $1." && return 0;

}

# make a directory, and cd into it
cmkdir() {
  mkdir -p $1 && cd $1
}

# make a directory, and move * into it
mkmv() {
  mkdir -p $1
  find . -maxdepth 1 -not -path . -not -name $1 -exec mv {} $1 \;
}

# get my IP address from various internet sources
myip() {
  local ican_ip=$(curl -s -f icanhazip.com)
  local ipch_ip=$(curl -s -f ipecho.net/plain)
  local idnt_ip=$(curl -s -f ident.me)
  echo -e "[myip] IP addresses (various sources):"
  echo -e "[icanhazip] \u2192 $ican_ip"
  echo -e "[ipechonet] \u2192 $ipch_ip"
  echo -e "[ident.me]  \u2192 $idnt_ip"
}
