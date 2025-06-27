#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

work_dir="$(dirname "${0}")"
PROJECT_ROOT="$(dirname "$(readlink -f "${work_dir}")")"

DOWNLOADED_MODULES_PATH="${PROJECT_ROOT}/submodules"
INSTALLED_MODULES_PATH="${PROJECT_ROOT}/extra-addons"
EXCLUDE="${work_dir}/exclude.txt"

for dir in "$DOWNLOADED_MODULES_PATH"/*/; do
  echo "Copying $dir into ${INSTALLED_MODULES_PATH}"
  rsync -av --exclude-from="${EXCLUDE}" "$dir" "${INSTALLED_MODULES_PATH}"
done
