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

# If user didn't explicitly set ZPM_BOOKMARKS_FILE, use XDG config
if [[ -z "$ZPM_BOOKMARKS_FILE" ]]; then
  ZPM_BOOKMARKS_FILE="${XDG_CONFIG_HOME}/zsh/bookmarks"
  # Migrate legacy file if it exists
  if [[ -f "$HOME/.bookmarks" ]]; then
    mkdir -p "${ZPM_BOOKMARKS_FILE:h}"
    mv "$HOME/.bookmarks" "$ZPM_BOOKMARKS_FILE"
  fi
fi

# Normalize file path
ZPM_BOOKMARKS_FILE=${ZPM_BOOKMARKS_FILE:A}

# Ensure directory exists
mkdir -p "${ZPM_BOOKMARKS_FILE:h}"

# Create file if it doesn't exist
if [[ ! -f $ZPM_BOOKMARKS_FILE ]]; then
  touch $ZPM_BOOKMARKS_FILE
fi

autoload -Uz mark marks c delmark @bookmark_path_colorize @bookmark_name_colorize @bookmark_join
