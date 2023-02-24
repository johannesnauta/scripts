#/bin/bash
declare -A pomo_options
pomo_options=(
    ["work"]="45"
    ["break"]="10"
    ["emacs"]="30"
)

pomodoro () {
  if [ -n "$1" -a -n "{pomo_options["$1"]}" ]; then
  val=$1;
  timer "${pomo_options["$val"]}m"
  notify-send "'$val' session done"
  fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"
alias em="pomodoro 'emacs'"
