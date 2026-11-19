#!/usr/bin/env bash
set -u

section() { printf '\n=== %s ===\n' "$1"; }
run_if_available() {
  local command_name="$1"
  shift
  if command -v "$command_name" >/dev/null 2>&1; then
    "$@" || true
  else
    printf '%s komutu yüklü değil.\n' "$command_name"
  fi
}

section "SİSTEM"
run_if_available uname uname -a
if [[ -r /etc/os-release ]]; then
  . /etc/os-release
  printf 'Dağıtım: %s\nSürüm: %s\n' "${PRETTY_NAME:-bilinmiyor}" "${VERSION_ID:-bilinmiyor}"
fi

section "BELLEK"
run_if_available free free -h

section "DEPOLAMA"
run_if_available lsblk lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS
if [[ -d /mnt/BilgiKutusu ]]; then
  run_if_available df df -h /mnt/BilgiKutusu
else
  echo "/mnt/BilgiKutusu bulunamadı."
fi

section "AĞ"
run_if_available ip ip -brief addr
run_if_available iw iw dev
run_if_available nmcli nmcli device status

section "SERVİSLER"
if command -v systemctl >/dev/null 2>&1; then
  for service in nginx kiwix-serve NetworkManager; do
    printf '%-18s ' "$service"
    systemctl is-active "$service" 2>/dev/null || true
  done
else
  echo "systemctl kullanılamıyor."
fi

section "PORTLAR"
if command -v ss >/dev/null 2>&1; then
  ss -lnt 2>/dev/null | awk 'NR == 1 || /:8080([[:space:]]|$)|:8081([[:space:]]|$)/'
else
  echo "ss komutu yüklü değil."
fi

section "WEB DOSYALARI"
for file in /var/www/bilgikutusu/index.html /var/www/bilgikutusu/assets/app.js /var/www/bilgikutusu/assets/style.css; do
  if [[ -r "$file" ]]; then
    printf 'OK      %s\n' "$file"
  else
    printf 'EKSİK   %s\n' "$file"
  fi
done

printf '\nBu betik sistem ayarlarını değiştirmez. Çıktı IP adresleri ve donanım bilgileri içerebilir; paylaşmadan önce gözden geçirin.\n'
