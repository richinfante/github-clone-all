#!/bin/bash

# author: Rich Infante <rich@richinfante.com>
# license: MIT

# find all directories two levels deep
# github-clone-all clones them in this fashion.
for REPO in `find . -mindepth 2 -maxdepth 2 -type d`
do
  echo "$REPO"
  echo "$(cd "$REPO" && git pull)"
done