#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
#          FILE:  zshmarks.plugin.zsh
#   DESCRIPTION:  zsh plugin file.
#        AUTHOR:  Jocelyn Mallon
#       VERSION:  2.0.0
# ------------------------------------------------------------------------------

# Standarized $0 handling, following:
# https://github.com/zdharma/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"

if [[ $PMSPEC != *f* ]] {
  fpath+=( "${0:h}/functions" )
}

# Set ZPM_BOOKMARKS_FILE if it doesn't exist to the default.
# Allows for a user-configured ZPM_BOOKMARKS_FILE.
ZPM_BOOKMARKS_FILE=${ZPM_BOOKMARKS_FILE:-"$HOME/.bookmarks"}

# Normalize file path
ZPM_BOOKMARKS_FILE=${ZPM_BOOKMARKS_FILE:A}

if [[ -e $ZPM_BOOKMARKS_FILE ]]; then
  echo "Please move file to XDG_CONFIG_HOME: $XDG_CONFIG_HOME/zsh/bookmarks"
else
  if [[ -e $XDG_CONFIG_HOME/zsh/bookmarks ]]; then
    # Set ZPM_BOOKMARKS_FILE to the new location
    ZPM_BOOKMARKS_FILE="${XDG_CONFIG_HOME}/zsh/bookmarks"
    # Normalize file path
    ZPM_BOOKMARKS_FILE=${ZPM_BOOKMARKS_FILE:A}
  fi
fi

# Create file it if it doesn't exist
if [[ ! -f $ZPM_BOOKMARKS_FILE ]]; then
  echo -n > $ZPM_BOOKMARKS_FILE
fi

autoload -Uz mark marks c delmark @bookmark_path_colorize @bookmark_name_colorize @bookmark_join
