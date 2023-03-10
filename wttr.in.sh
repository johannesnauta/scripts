#!/bin/bash
declare -A wttr_options
BASE_URL="wttr.in"
wttr_options=(
    ["full"]="/?nQ"
    ["today"]="/?1nQ"
    ["tomorrow"]="/?n2Q, 10"
)

wttr.in () {
  if [ $# -eq 0 ]; then
      curl -s "${BASE_URL}/?n2Q" | head -n -2
  elif [ "$1" ] && [ ${wttr_options[$1]} ]; then
      STRING=${wttr_options["$1"]};
      IFS=#
      fields=(${STRING//, /#})  # Be mindful of whitespaces!
      URL=${fields[0]}          # Extract (base) url
      if   [ "$1" == "full" ] || [ "$1" == "today" ]; then
          curl -s "$BASE_URL$URL" | head -n -2
      elif [ "$1" == "tomorrow" ]; then
          LINES=${fields[1]}        # Extract number of lines to omit
          curl -s "$BASE_URL$URL" | head -n -2 | tail -n -$LINES
      fi
  else
      echo "Option '$1' not recognized. Available options '${!wttr_options[@]}'"
  fi
}

alias weather="wttr.in"
