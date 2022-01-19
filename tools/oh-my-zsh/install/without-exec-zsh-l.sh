#!/bin/sh
# Install oh-my-zsh from "oh-my-zsh/oh-my-zsh"
sh -c "$( \
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o - | \
    # Without exec zsh -l
    sed 's/exec zsh -l//g' | \
    # Without read -r opt => opt="y" => chsh => zsh
    sed 's/read\ \-r\ opt/opt="y"/'
)"