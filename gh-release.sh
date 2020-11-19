#!/usr/bin/env bash
set -euo pipefail
set -x
PQCHECKER_VERSION=$(grep 'ENV PQCHECKER_VERSION' Dockerfile |awk -F\' '{ print $2 }')
GITHUB_REPOSITORY=${CI_PROJECT_NAME}
GITHUB_RELEASE_NAME="pqChecker v${PQCHECKER_VERSION}-$(date '+%d%m%Y-%Hh%Mm')"

GITHUB_RELEASES_CHECK=$(curl -s https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases|grep 'tag_name'|grep ${PQCHECKER_VERSION}|wc -l)

if [[ ${GITHUB_RELEASES_CHECK} -eq 0 ]];
then
  echo 'Creating GITHUB release...'
  GITHUB_RELEASE=$(curl -sS -XPOST -H "Authorization:token ${GITHUB_TOKEN}" --data "{\"tag_name\": \"v${PQCHECKER_VERSION}\", \"target_commitish\": \"master\", \"name\": \"${GITHUB_RELEASE_NAME}\", \"body\": \"pqChecker Debian package\", \"draft\": false, \"prerelease\": false}" https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases)
  echo "GITHUB release ${GITHUB_RELEASE_NAME} created."
else
  echo 'GITHUB release not created. A GITHUB release named ${GITHUB_RELEASE_NAME} already exist.'
fi

exit 0
