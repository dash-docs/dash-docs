#!/bin/bash
# Run before building to initialize Ruby stuff
# See docs/setting-up-your-environment.md for more info

source ~/.rvm/scripts/rvm

# Set default Ruby
rvm alias create default ruby-2.5.0
rvm use default
