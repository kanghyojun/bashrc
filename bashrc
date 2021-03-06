source $HOME/.bash_env
source $HOME/.bash_alias

set -o vi


c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

parse_git_branch ()
{
   if git rev-parse --git-dir >/dev/null 2>&1
   then
      gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
   else
      return 0
   fi
   echo -e $gitver
}

branch_color ()
{
   if git rev-parse --git-dir >/dev/null 2>&1
   then
      color=""
      if git diff --quiet 2>/dev/null >&2
      then
         color="${c_green}"
      else
         color=${c_red}
      fi
   else
      return 0
   fi
   echo -ne $color
}

export PS1='\u @ \W\[${c_sgr0}\] \[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='rg -l ""'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
