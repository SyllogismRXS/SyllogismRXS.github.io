#!/bin/bash

# Get the directory containing this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

STATIC_PAGES_DIR="${DIR}/../../static-blog"

# Make sure the static pages directory is updated:
pushd ${STATIC_PAGES_DIR}
  git pull origin master
popd > /dev/null

# change to the directory that contains this script
pushd ${DIR}
  # Build the jekyll site and copy to static pages directory
  JEKYLL_ENV=production bundle exec jekyll build
  cp -r _site/* ${STATIC_PAGES_DIR}
popd >& /dev/null
