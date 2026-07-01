# Primer job Spark local

Este documento valida que Sparky puede ejecutar un trabajo Apache Spark sobre Kubernetes local usando Spark Operator.

## Flujo

1. Kubernetes local se ejecuta con kind.
2. Spark Operator observa recursos SparkApplication.
3. Se crea un SparkApplication llamado spark-pi.
4. Spark Operator crea un pod driver.
5. El driver crea pods executor.
6. El resultado se consulta desde los logs del driver.

## Comandos principales

```bash
kubectl apply -f manifests/platform/spark-rbac.yaml
docker pull apache/spark:4.0.3
kind load docker-image apache/spark:4.0.3 --name sparky-lab
kubectl apply -f manifests/spark/spark-pi.yaml
kubectl get sparkapplications -n spark
kubectl get pods -n spark -o wide

## LOGS
DRIVER_POD=$(kubectl get pods -n spark \
  -l spark-role=driver,spark-app-name=spark-pi \
  -o jsonpath='{.items[0].metadata.name}')

kubectl logs -n spark "$DRIVER_POD"

