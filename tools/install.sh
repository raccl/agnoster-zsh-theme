#!/bin/sh
# Install oh-my-zsh from "oh-my-zsh/oh-my-zsh" without exec zsh -l
echo 'Install oh-my-zsh from "oh-my-zsh/oh-my-zsh"'
sh -c "$(curl -LsSf https://raw.githubusercontent.com/raccl/agnoster-zsh-theme/master/tools/oh-my-zsh/install/without-exec-zsh-l.sh)"

# Set Theme to agnoster
echo 'Set Theme to agnoster'
sh -c "$(curl -LsSf https://raw.githubusercontent.com/raccl/agnoster-zsh-theme/master/tools/themes/set/agnoster.sh)"

# Update Theme agnoster
echo 'Update Theme agnoster'
sh -c "$(curl -LsSf https://raw.githubusercontent.com/raccl/agnoster-zsh-theme/master/tools/themes/update/agnoster.sh)"

exec zsh -l
