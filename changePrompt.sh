#!/bin/bash

# add user and host for oh-my-zsh prompt

sed -i -e 's/PROMPT=/PROMPT='%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%} ${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'/g' ~/.oh-my-zsh/themes/robbyrussell.zsh-theme