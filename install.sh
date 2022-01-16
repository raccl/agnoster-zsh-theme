#!/bin/sh
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
# Replace robbyrussell to agnoster
sed -i 's/robbyrussell/agnoster/g' ~/.zshrc
# Install agnoster
curl -LsSf https://raw.githubusercontent.com/raccl/agnoster-zsh-theme/master/agnoster.zsh-theme -o ~/.oh-my-zsh/themes/agnoster.zsh-theme
