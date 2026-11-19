#!/usr/bin/env bash
set -Eeuo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Kullanım: sudo bash scripts/install-web.sh" >&2
  exit 1
fi

SOURCE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../web" && pwd -P)"
WEB_ROOT="/var/www"
TARGET_DIR="${WEB_ROOT}/bilgikutusu"
STAGING_DIR="${WEB_ROOT}/.bilgikutusu-staging-$$"

cleanup() { rm -rf -- "$STAGING_DIR"; }
trap cleanup EXIT

if [[ ! -f "${SOURCE_DIR}/index.html" || ! -f "${SOURCE_DIR}/assets/app.js" || ! -f "${SOURCE_DIR}/assets/style.css" ]]; then
  echo "Web kaynakları eksik. Beklenen index.html, assets/app.js ve assets/style.css." >&2
  exit 1
fi

if [[ -e "$TARGET_DIR" || -L "$TARGET_DIR" ]]; then
  echo "Hedef zaten mevcut: $TARGET_DIR" >&2
  echo "Mevcut kurulum korunuyor. Yedek alıp hedefi elle taşıdıktan sonra tekrar deneyin." >&2
  exit 2
fi

install -d -m 0755 "$WEB_ROOT"
install -d -m 0755 "$STAGING_DIR"
cp -R --no-preserve=ownership "$SOURCE_DIR/." "$STAGING_DIR/"
find "$STAGING_DIR" -type d -exec chmod 0755 {} +
find "$STAGING_DIR" -type f -exec chmod 0644 {} +

# -T prevents moving the staging directory inside a target created concurrently.
mv -T -- "$STAGING_DIR" "$TARGET_DIR"
trap - EXIT

echo "Portal kuruldu: $TARGET_DIR"
echo "Nginx yapılandırması değiştirilmedi; ayrıca yapılandırıp test edin."
