#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TAG_NAME="${1:-}"
if [[ -z "${TAG_NAME}" ]]; then
  echo "usage: $0 <tag>" >&2
  exit 1
fi

ADDON_NAME="MonkFighter2"
DIST_DIR="${ROOT_DIR}/dist"
STAGE_DIR="${DIST_DIR}/stage"
PACKAGE_DIR="${STAGE_DIR}/${ADDON_NAME}"
ZIP_NAME="${ADDON_NAME}-${TAG_NAME}.zip"
ZIP_PATH="${DIST_DIR}/${ZIP_NAME}"

rm -rf "${STAGE_DIR}" "${ZIP_PATH}"
mkdir -p "${PACKAGE_DIR}"

rsync -a \
  --exclude '.git/' \
  --exclude '.github/' \
  --exclude '.pkgmeta' \
  --exclude '.gitignore' \
  --exclude 'AGENTS.md' \
  --exclude 'CHANGELOG.txt' \
  --exclude 'README.md' \
  --exclude 'MonkFighter2.zip' \
  --exclude 'dist/' \
  --exclude 'scripts/' \
  "${ROOT_DIR}/" "${PACKAGE_DIR}/"

(
  cd "${STAGE_DIR}"
  python3 - "${ADDON_NAME}" "${ZIP_PATH}" <<'PY'
import os
import sys
import zipfile

addon_name = sys.argv[1]
zip_path = sys.argv[2]

with zipfile.ZipFile(zip_path, "w", compression=zipfile.ZIP_DEFLATED) as archive:
    for root, _, files in os.walk(addon_name):
        for file_name in files:
            file_path = os.path.join(root, file_name)
            archive.write(file_path, file_path)
PY
)

echo "${ZIP_PATH}"
