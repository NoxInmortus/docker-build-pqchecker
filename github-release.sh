#!/usr/bin/env bash
set -euo pipefail
GENERATED_FILE=pqchecker_${PQCHECKER_VERSION}-1_${ARCH}

RELEASE=$(curl -XPOST -H "Authorization:token ${GITHUB_TOKEN}" --data "{\"tag_name\": \"v${PQCHECKER_VERSION}\", \"target_commitish\": \"master\", \"name\": \"pqChecker v${PQCHECKER_VERSION}\", \"body\": \"pqChecker Debian package\", \"draft\": false, \"prerelease\": false}" https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases)

RELEASE_ID=$(echo "${RELEASE}" | sed -n -e 's/"id":\ \([0-9]\+\),/\1/p' | head -n 1 | sed 's/[[:blank:]]//g')

echo "Release id : ${RELEASE_ID}"

sha1sum /tmp/${GENERATED_FILE}.deb > /tmp/${GENERATED_FILE}.sha1sum

curl -XPOST -H "Authorization:token ${GITHUB_TOKEN}" -H "Content-Type:application/octet-stream" --data-binary /tmp/${GENERATED_FILE}.deb https://uploads.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}/assets?name=${GENERATED_FILE}.deb

curl -XPOST -H "Authorization:token ${GITHUB_TOKEN}" -H "Content-Type:application/octet-stream" --data-binary /tmp/${GENERATED_FILE}.sha1sum https://uploads.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}/assets?name=${GENERATED_FILE}.sha1sum
