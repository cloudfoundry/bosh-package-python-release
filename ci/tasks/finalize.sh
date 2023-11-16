#!/usr/bin/env bash

set -eux

# invariants
cp semver/version bumped-semver/version
cp -rfp ./python-release/. finalized-release

# finalize
export FULL_VERSION=$(cat semver/version)

pushd finalized-release
  git status

  set +x
  echo "${PRIVATE_YML}" > config/private.yml
  set -x

  bosh create-release --tarball=/tmp/bosh-dev-release.tgz --timestamp-version --force
  bosh finalize-release --version $FULL_VERSION /tmp/bosh-dev-release.tgz

  git add -A
  git status

  git config user.name "CI Bot"
  git config user.email "cf-bosh-eng@pivotal.io"

  git commit -m "Adding final release $FULL_VERSION via concourse"
popd

echo "v${FULL_VERSION}" > version-tag/tag-name
echo "Final release ${FULL_VERSION} tagged via concourse" > version-tag/annotate-msg
