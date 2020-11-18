#!/usr/bin/env bash
set -euo pipefail

PATH=${PATH}:/usr/local/go/bin
GENERATED_FILE=pqchecker_${PQCHECKER_VERSION}-1_${ARCH}
github-release --version

if [ $(github-release info --user ${GITHUB_USER} --repo ${GITHUB_REPOSITORY} --tag v${PQCHECKER_VERSION}|grep v${PQCHECKER_VERSION}|grep -v commit|wc -l) -eq 0 ];
then
  github-release -v release \
      --user ${GITHUB_USER} \
      --repo ${GITHUB_REPOSITORY} \
      --tag v${PQCHECKER_VERSION} \
      --name "pqChecker-${PQCHECKER_VERSION}" \
      --description "Multiarch pqChecker debian package."

      # wait for the release to be created
      # otherwise the upload will fail
      sleep 5
fi

sha1sum /tmp/${GENERATED_FILE}.deb > /tmp/${GENERATED_FILE}.sha1sum

github-release -v upload \
    --user ${GITHUB_USER} \
    --repo ${GITHUB_REPOSITORY} \
    --tag v${PQCHECKER_VERSION} \
    --name "${GENERATED_FILE}.deb" \
    --file /tmp/${GENERATED_FILE}.deb

github-release -v upload \
    --user ${GITHUB_USER} \
    --repo ${GITHUB_REPOSITORY} \
    --tag v${PQCHECKER_VERSION} \
    --name "${GENERATED_FILE}.sha1sum" \
    --file /tmp/${GENERATED_FILE}.sha1sum
