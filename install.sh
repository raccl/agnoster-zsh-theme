#!/bin/sh
# Install oh-my-zsh from "oh-my-zsh/oh-my-zsh"
echo 'Install oh-my-zsh from "oh-my-zsh/oh-my-zsh"'
sh -c "$( \
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o - | \
    # Without exec zsh -l
    sed 's/exec zsh -l//g' \
)"

# Set Theme to agnoster
echo 'Set Theme to agnoster'
sh -c "$(curl -LsSf https://raw.githubusercontent.com/raccl/agnoster-zsh-theme/master/tools/set.sh)"

# Update Theme agnoster
echo 'Update Theme agnoster'
sh -c "$(curl -LsSf https://raw.githubusercontent.com/raccl/agnoster-zsh-theme/master/tools/update.sh)"
