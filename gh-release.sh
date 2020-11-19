#!/usr/bin/env bash
set -euo pipefail
PQCHECKER_VERSION=${1}
GITHUB_REPOSITORY=${CI_PROJECT_NAME}

GITHUB_RELEASE=$(curl -s --no-progress-meter -XPOST -H "Authorization:token ${GITHUB_TOKEN}" --data "{\"tag_name\": \"v${PQCHECKER_VERSION}\", \"target_commitish\": \"master\", \"name\": \"pqChecker v${PQCHECKER_VERSION}\", \"body\": \"pqChecker Debian package\", \"draft\": false, \"prerelease\": false}" https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases)

GITHUB_RELEASE_ID=$(echo "${GITHUB_RELEASE}" | sed -n -e 's/"id":\ \([0-9]\+\),/\1/p' | head -n 1 | sed 's/[[:blank:]]//g')

echo 'RELEASE ID :' ${GITHUB_RELEASE_ID}
