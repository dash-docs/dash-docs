#!/bin/sh
################################################################################
# Title         : build-install-doxygen.sh
# Date created  : 2018/02/01
# Notes         :
__AUTHOR__="thephez"
#
# If the doxygen binary is not found, clones the doxygen repository, builds,
# and copies the binary to a location for Travis-CI caching.
#
################################################################################

set -ex

file="$TRAVIS_BUILD_DIR/doxygen-install/doxygen"

# Only build Doxygen if the binary isn't found
if [ -f "$file" ]
then
  echo "Doxygen binary found. Skipping build."
else

  echo "Doxygen binary not found. Building from source..."

  # Build instructions from: https://www.stack.nl/~dimitri/doxygen/download.html
  echo "Cloning doxygen repository..."
  git clone https://github.com/doxygen/doxygen.git doxygen-src

  cd doxygen-src

  # Use v1.8.14 (2f4139de014bf03898320a45fe52c92872c1e0f4)
  git checkout 2f4139de014bf03898320a45fe52c92872c1e0f4 .

  echo "Create build folder..."
  mkdir build
  cd build

  echo "Make..."
  cmake -G "Unix Makefiles" ..
  make

  echo "Done building doxygen..."
  ./bin/doxygen -v

  echo "Copy Doxygen binary to folder for caching..."
  mkdir -p $TRAVIS_BUILD_DIR/doxygen-install
  cp bin/doxygen $TRAVIS_BUILD_DIR/doxygen-install/

  cd $TRAVIS_BUILD_DIR
fi
