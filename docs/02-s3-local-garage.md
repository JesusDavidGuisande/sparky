# S3 local con Garage

Sparky usa un almacenamiento S3 local para evitar montar directorios del host directamente dentro de los pods Spark.

## Objetivo

Disponer de un bucket local compatible con S3 para datos de entrada y salida de los trabajos Spark.

## Arquitectura

Kubernetes namespace: storage

Componentes:

- Deployment garage
- Service garage
- PVC garage-meta
- PVC garage-data
- Secret garage-s3-credentials

Endpoint interno para pods dentro del clúster:

```text
http://garage.storage.svc.cluster.local:3900
