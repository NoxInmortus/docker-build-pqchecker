#!/usr/bin/env bash
set -euo pipefail
set -x
PQCHECKER_VERSION=$(grep 'ENV PQCHECKER_VERSION' Dockerfile |awk -F\' '{ print $2 }')
GITHUB_REPOSITORY=${CI_PROJECT_NAME}
GITHUB_RELEASE_NAME="pqChecker v${PQCHECKER_VERSION}"

GITHUB_RELEASES_CHECK=$(curl -s https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases|grep 'tag_name'|grep ${PQCHECKER_VERSION}|wc -l)

if [ ${GITHUB_RELEASES_CHECK} -eq 0 ];
  echo 'Creating GITHUB release...'
  GITHUB_RELEASE=$(curl -s -XPOST -H "Authorization:token ${GITHUB_TOKEN}" --data "{\"tag_name\": \"v${PQCHECKER_VERSION}\", \"target_commitish\": \"master\", \"name\": \"${GITHUB_RELEASE_NAME}\", \"body\": \"pqChecker Debian package\", \"draft\": false, \"prerelease\": false}" https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases)
  GITHUB_RELEASE_ID=$(echo "${GITHUB_RELEASE}" | sed -n -e 's/"id":\ \([0-9]\+\),/\1/p' | head -n 1 | sed 's/[[:blank:]]//g')
  echo ${GITHUB_RELEASE_ID}
else
  echo 'GITHUB release not created. A GITHUB release named ${GITHUB_RELEASE_NAME} already exist.'
fi
