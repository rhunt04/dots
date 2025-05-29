#!/bin/bash
# Ryan's bash functions file

log() {
  # Print messages neatly when called from within a bash function.

  # FUNCNAME[0] would be "log", so go for the caller function, one-level up.
  echo "[${FUNCNAME[1]}] $1"
}

backupImage() {
  # Check disk exists, check not mounted, check have space ...
  sudo dd bs=4M if=/dev/mmcblk0 | gzip >/home/ryan/BackupImage$(date +%d%m%y).gz
}

tarball() {
  # Make a file or directory into a tarball.

  [ $# -eq 0 ] && log "no arguments supplied." && return 1

  # remove trailing slash (possible if directory fed in)
  for fdir in "${@%/}"; do

    # fdir is a directory or file?
    [[ ! -f "$fdir" ]] && [[ ! -d "$fdir" ]] &&
      log "\"$fdir\" not file or directory." && continue

    tar -czvf "${fdir}.tgz" "$fdir"

  done

  log "done tarring." && return 0
}

extract() {
  # Extract a variety of archives.
  [ $# -eq 0 ] && log "no arguments supplied." && return 1
  [ ! -f "$1" ] && log "file \"$1\" doesn't exist." && return 1

  log "preparing $1."
  case $1 in
  *.tgz | *.tar.gz)
    tar xvzf "$1" 2>&1
    ;;
  *.tbz | *.tbz2 | *.tar.bz2)
    tar xvjf "$1" 2>&1
    ;;
  *.gz) gunzip "$1" 2>&1 ;;
  *.tar) tar xvf "$1" 2>&1 ;;
  *.bz2) bunzip2 "$1" 2>&1 ;;
  *.rar) unrar x "$1" 2>&1 ;;
  *.zip) unzip "$1" 2>&1 ;;
  *.7z) 7z x "$1" 2>&1 ;;
  *.xz) unxz "$1" 2>&1 ;;
  *.lzma) unlmza "$1" 2>&1 ;;
  *) log "file \"$1\" is not valid." && return 1 ;;
  esac
  log "done extracting $1." && return 0

}

cmkdir() {
  # Make a directory, and cd into it.
  mkdir -p "${1}" && cd "${1}" || return
}

trimtrail() {

  # trim trailing space from a file.
  [ $# -eq 0 ] && log "no arguments supplied." && return 1

  # remove trailing slash (possible if directory fed in)
  for fdir in "${@%/}"; do
    [[ ! -f "$fdir" ]] && log "\"$fdir\" not file." && continue
    sed -i 's/[ \t]*$//' "${fdir}"
  done

}

mkmv() {
  # Make a directory, and move * into it.
  mkdir -p "${1}"
  find . -maxdepth 1 -not -path . -not -name "${1}" -exec mv {} "${1}" \;
}

myip() {
  # Get my IP address from various internet sources.
  ican_ip=$(curl -s -f icanhazip.com)
  ipch_ip=$(curl -s -f ipecho.net/plain)
  idnt_ip=$(curl -s -f ident.me)
  echo -e "[myip] IP addresses (various sources):"
  echo -e "[icanhazip] \u2192 $ican_ip"
  echo -e "[ipechonet] \u2192 $ipch_ip"
  echo -e "[ident.me]  \u2192 $idnt_ip"
}

boomerise() {
  #sed -E 's/(.)(.)?/\U\1\L\2/g' <<< $@

  if (($# == 0)); then
    sed -E 's/(.)(.)?/\U\1\L\2/g' </dev/stdin
  else
    sed -E 's/(.)(.)?/\U\1\L\2/g' <<<"${@}"
  fi
}

get_key() {
  # Try to match the first (space-separated) entry following $1 on a
  # line which looks like: "^$1 <key> <key2> <key3> ...$", in file $2.
  local _res
  _res=$(grep -Po "^${1}\\s*\\K([^ ]*)" "${2}")
  echo "res: '${_res}'."
}

epstopng() {
  # check if file etc...

  epstopdf "${1}"
  base="${1%.*}"
  pdftoppm "${base}.pdf" -png >"${base}.png"
  mogrify -trim -rotate 90 "${base}.png"
  rm "${1}" "${base}.pdf"

}

clear_clipboard() {
  sleep "${1:-10}"
  xclip -sel clip </dev/null
}

c2f() {
  [ ! -z "${1}" ] && xclip -o >"${1}" && log "copied to \"${1}\"."
}

rand_tldr() {
  page=$(tldr --list | shuf -n 1)
  figlet --gay -f smblock "  ${page}"
  tldr "${page}"
}

rman() {
  log "Opening random man page…"
  choice=$(man -k . | awk '{print $1}' | sort -R | tail -1)
  man "${choice}"
}

getpass() {
  # Get password, timeout 1min.
  keepassxc-cli clip ~/Documents/ryan_dbase.kdbx "${1}"
  echo "Clearing in 10s."
  clear_clipboard 10 &
}

send_to_phone() {
  bt-obex -p EC:AA:25:5C:BF:7D "${1}"
}

send_to_tablet() {
  bt-obex -p 00:BB:1C:1A:7F:79 "${1}"
}

send_to_red() {
  bt-obex -p 74:29:AF:7F:30:18 "${1}"
}
