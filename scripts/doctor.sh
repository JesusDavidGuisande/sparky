#!/usr/bin/env bash
set -euo pipefail

check_cmd() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "[OK] $cmd: $(command -v "$cmd")"
  else
    echo "[ERROR] No se encuentra $cmd"
    exit 1
  fi
}

echo "== Comprobación de herramientas locales =="
check_cmd docker
check_cmd kind
check_cmd kubectl
check_cmd helm
check_cmd java
check_cmd python3

echo
echo "== Docker =="
docker version --format 'Client: {{.Client.Version}} | Server: {{.Server.Version}}'

echo
echo "== kind =="
kind version

echo
echo "== kubectl =="
kubectl version --client=true

echo
echo "== helm =="
helm version --short

echo
echo "[OK] Comprobación básica completada"
