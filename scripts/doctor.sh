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
check_cmd aws

echo
echo "== Docker =="
docker version --format 'Client: {{.Client.Version}} | Server: {{.Server.Version}}'

echo
echo "== kind =="
kind version
echo "Clusters kind:"
kind get clusters || true

echo
echo "== kubectl =="
kubectl version --client=true

echo
echo "== helm =="
helm version --short

echo
echo "== Kubernetes =="
if kubectl cluster-info >/dev/null 2>&1; then
  echo "[OK] Kubernetes accesible"
  kubectl get nodes -o wide
else
  echo "[ERROR] Kubernetes no accesible desde el contexto actual"
  exit 1
fi

echo
echo "== Spark Operator =="
if kubectl get namespace spark-operator >/dev/null 2>&1; then
  kubectl get pods -n spark-operator
  kubectl get crd | grep -i spark || true
else
  echo "[WARN] Namespace spark-operator no encontrado"
fi

echo
echo "== Namespace spark =="
if kubectl get namespace spark >/dev/null 2>&1; then
  kubectl get sparkapplications -n spark || true
  kubectl get pods -n spark || true
else
  echo "[WARN] Namespace spark no encontrado"
fi

echo
echo "== Garage S3 local =="
if kubectl get deployment garage -n storage >/dev/null 2>&1; then
  kubectl get pods -n storage
  kubectl get pvc -n storage
  kubectl get svc -n storage
else
  echo "[WARN] Garage no está instalado en namespace storage"
fi

echo
echo "[OK] Doctor finalizado"
