#!/usr/bin/env bash
set -euo pipefail
set -x

GENERATED_FILE=pqchecker_${PQCHECKER_VERSION}-1_${ARCH}
GITHUB_RELEASE_ID=$(curl -sSLk --retry 5 https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases/latest|grep '\"url\"'|head -n 1|awk -F\" '{ print $(NF-1) }'|awk -F/ '{ print $NF }')

echo "Release id : ${GITHUB_RELEASE_ID}"

sha1sum /tmp/${GENERATED_FILE}.deb > /tmp/${GENERATED_FILE}.sha1sum
curl -sSLk --retry 5 -XPOST -H "Authorization:token ${GITHUB_TOKEN}" -H "Content-Type:application/octet-stream" --data-binary @/tmp/${GENERATED_FILE}.deb https://uploads.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases/${GITHUB_RELEASE_ID}/assets?name=${GENERATED_FILE}.deb
curl -sSLk --retry 5 -XPOST -H "Authorization:token ${GITHUB_TOKEN}" -H "Content-Type:application/octet-stream" --data-binary @/tmp/${GENERATED_FILE}.sha1sum https://uploads.github.com/repos/${GITHUB_USER}/${GITHUB_REPOSITORY}/releases/${GITHUB_RELEASE_ID}/assets?name=${GENERATED_FILE}.sha1sum

exit 0
