#!/bin/sh
################################################################################
# Title         : generateDocumentationAndDeploy.sh
# Date created  : 2016/02/22
# Notes         : Modified the thephez for deploying with dash-docs
__AUTHOR__="Jeroen de Bruijn"
# Preconditions:
# - Doxygen must be installed or loaded from cache. The build-install-doxygen
#   script should be used to do this
# - A Doxygen configuration file must be located in the TRAVIS_BUILD_DIR/doxygen
#   directory
# - This script should be called after the rest of the site has already been
#   built (i.e. in the Travis-CI after_success section)
#
# Required global variables:
# - DOXYFILE            : The Doxygen configuration file.
#
# For information on how to encrypt variables for Travis CI please go to
# https://docs.travis-ci.com/user/environment-variables/#Encrypted-Variables
# or https://gist.github.com/vidavidorra/7ed6166a46c537d3cbd2
# For information on how to create a clean gh-pages branch from the master
# branch, please go to https://gist.github.com/vidavidorra/846a2fc7dd51f4fe56a0
#
# This script will generate Doxygen documentation and copy the documentation to
# the _site/_en directory of dash-docs so it can be deployed with the rest of
# the site
#
################################################################################

################################################################################
##### Setup this script and clone the Dash repository                      #####
echo 'Setting up the script...'
# Exit with nonzero exit code if anything fails
set -e

# Clone Dash Core
git clone https://github.com/dashpay/dash.git
cd dash

# Copy Doxygen config / build files
cp $TRAVIS_BUILD_DIR/doxygen/* doc/

################################################################################
##### Generate the Doxygen code documentation and log the output.          #####
echo 'Generating Doxygen code documentation...'
# Redirect both stderr and stdout to the log file AND the console.
$TRAVIS_BUILD_DIR/doxygen-install/doxygen doc/$DOXYFILE 2>&1 | tee doxygen.log

echo 'Done generating Doxygen code documentation...'
#cat doxygen.log

# Copy Doxygen files to dash-docs folder
echo 'Copy Doxygen files to _site...'
cp -R doc/doxygen $TRAVIS_BUILD_DIR/_site/en/
