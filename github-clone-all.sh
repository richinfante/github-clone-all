#!/bin/bash

# author: Rich Infante <rich@richinfante.com>
# license: MIT

# read GITHUB_USER of not set
if [[ "$GITHUB_USER" == "" ]]; then
  read -p "Github User: " GITHUB_USER
fi

# read GITHUB_TOKEN if not set
if [[ "$GITHUB_TOKEN" == "" ]]; then
  read -s -p "Github Token: " GITHUB_TOKEN
fi

# execute a clone of a url
# create directories if they don't exist.
function run_clone () {
  # Get the parameter as the url
  REPO_URL="$@"

  # Cut the username and reponame out of it.
  USER="$(echo $REPO_URL | cut -d '/' -f4)"
  REPONAME="$(echo $REPO_URL | cut -d '/' -f5)"
  REPONAME="$(basename -s ".git" "$REPONAME")"

  # Make a folder for the user's repos
  mkdir -p "$USER"

  # Clone (if exists, this'll fail!)
  git clone "$REPO_URL" "$USER/$REPONAME"
}

PER_PAGE="100"
PAGE="1"

# Load all pages
# GitHub's page size limit seems to be 100, so paginate using it.
while true; do
  # Load urls list
  URLS="$(curl -u $GITHUB_USER:$GITHUB_TOKEN -s "https://api.github.com/user/repos?per_page=$PER_PAGE&page=$PAGE" | jq -r '.[].clone_url')"

  # load line cont
  LINE_COUNT="$(echo "$URLS" | wc -l)"
  echo "got $LINE_COUNT repos"

  # Turn urls into an iterable my separating with spaces.
  URLS="$(echo "$URLS" | tr '\n' ' ')"

  # for each repo, clone it.
  for REPO in $URLS; do
    echo "$REPO"
    run_clone "$REPO"
  done
  
  # Linecount's not what we expected, break.
  if [[ "$((PER_PAGE))" != "$((LINE_COUNT))" ]]; then
    break
  fi

  # increment page counter
  PAGE=$((PAGE+1))
done
