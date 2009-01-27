# This method doesn't include untracked files
function _git_parse_dirty {
  git diff --quiet 2>&- || echo -n "*"
}

# This method is slower, but does include untracked files
function _git_parse_unclean {
  git status 2>&- | grep -q 'working directory clean' || echo -n "*"
}

function git_prompt {
  ref=$(git symbolic-ref HEAD 2>&-) || return
  echo "[${ref#refs/heads/}]"
}

function git_prompt_with_dirty {
  ref=$(git symbolic-ref HEAD 2>&-) || return
  echo "[${ref#refs/heads/}$(_git_parse_dirty)]"
}


# Then put something like this in your prompt:
# %{$fg_bold[yellow]%}$(git_prompt)%{$reset_color%}
