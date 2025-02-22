# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segments of the prompt, default order declaration

typeset -aHg AGNOSTER_PROMPT_SEGMENTS=(
    prompt_status
    prompt_virtualenv
    prompt_operating_system
    prompt_newline
    prompt_machine_architect
    prompt_newline
    prompt_microcode
    prompt_newline
    prompt_cpu_bugs
    prompt_newline
    prompt_cpu_base_clock
    prompt_newline
    prompt_kernel_release
    prompt_newline
    prompt_hostname
    prompt_newline
    prompt_username
    prompt_newline
    prompt_dir
    prompt_newline
    prompt_git_username
    prompt_newline
    prompt_git
    prompt_newline
    prompt_end
)
prompt_newline() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR
%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi

  echo -n "%{%f%}"
  CURRENT_BG=''
}
### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
	PRIMARY_FG=black
fi

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Hostname: @hostname (where am I and who am I on git)
prompt_hostname() {
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment "#a8f" $PRIMARY_FG " %(!.%{%F{yellow}%}.) @%m "
  fi
}


# Operating System : # $(uname -o) (on what OS)
prompt_operating_system() {
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment "#f8b" $PRIMARY_FG " %(!.%{%F{yellow}%}.) # $(uname -o)"
  fi
}

# Machine Architect : # $(uname -m) (machine hardware)
prompt_machine_architect() {
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment "#fab" $PRIMARY_FG " %(!.%{%F{yellow}%}.) # $(uname -m)"
  fi
}

# Microcode : # $(cat /proc/cpuinfo | grep microcode | uniq | rev | cut -d ':' -f1 | rev)
prompt_microcode(){
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    local MICROCODE=`cat /proc/cpuinfo | grep microcode | uniq | rev | cut -d ':' -f1 | rev`
    prompt_segment "#8ca" $PRIMARY_FG " %(!.%{%F{yellow}%}.) # $MICROCODE"
  fi
}

# Cpu Bugs : # $(cat /proc/cpuinfo | grep bugs | uniq | rev | cut -d ':' -f1 | rev)
prompt_cpu_bugs(){
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    local CPU_BUGS=`cat /proc/cpuinfo | grep bugs | uniq | rev | cut -d ':' -f1 | rev`
    prompt_segment "#a7b" $PRIMARY_FG " %(!.%{%F{yellow}%}.) ! $CPU_BUGS"
  fi
}

# Cpu Base Clock : # $(cat /proc/cpuinfo | grep name | uniq | rev | cut -d ':' -f1 | cut -d '@' -f1 | rev)
prompt_cpu_base_clock(){
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    local CPU_BASE_CLOCK=`cat /proc/cpuinfo | grep name | uniq | rev | cut -d ':' -f1 | cut -d '@' -f1 | rev`
    prompt_segment "#bb7" $PRIMARY_FG " %(!.%{%F{yellow}%}.) * $CPU_BASE_CLOCK"
  fi
}

# Kernel Release : # $(uname -r) (kernel release)
prompt_kernel_release() {
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment "#b4f" $PRIMARY_FG " %(!.%{%F{yellow}%}.) # $(uname -r)"
  fi
}

# Username: @username (where am I and who am I on git)
prompt_username() {
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment "#8af" $PRIMARY_FG " %(!.%{%F{yellow}%}.) @%n "
  fi
}

# Git Username: git.user.name@git (who am I on git) # ! Alwayts shown !
prompt_git_username() {
  local user=`git config user.name`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment "#8fa" $PRIMARY_FG " %(!.%{%F{yellow}%}.)$user@git "
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=yellow
      ref="${ref} $PLUSMINUS"
    else
      color=green
      ref="${ref} "
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRANCH $ref"
    else
      ref="$DETACHED ${ref/.../}"
    fi
    prompt_segment $color $PRIMARY_FG
    print -n " $ref"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment "#f8a" $PRIMARY_FG ' %~ '
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$CROSS"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$LIGHTNING"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}$GEAR"

  [[ -n "$symbols" ]] && prompt_segment $PRIMARY_FG default " $symbols "
}

# Display current virtual environment
prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV ]]; then
    color=cyan
    prompt_segment $color $PRIMARY_FG
    print -Pn " $(basename $VIRTUAL_ENV) "
  fi
}

## Main prompt
prompt_agnoster_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  for prompt_segment in "${AGNOSTER_PROMPT_SEGMENTS[@]}"; do
    [[ -n $prompt_segment ]] && $prompt_segment
  done
}

prompt_agnoster_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_agnoster_main) '
}

prompt_agnoster_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_agnoster_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_agnoster_setup "$@"
