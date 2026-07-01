# Arquitectura local de Sparky

Sparky es una herramienta/laboratorio para ejecutar trabajos Apache Spark sobre Kubernetes en local.

El objetivo inicial es disponer de un entorno reproducible en un PC o laboratorio pequeño para hacer pruebas de concepto.

## Arquitectura objetivo

Sistema Operativo | (Debian 13)
└── Docker Engine
    └── kind
        └── Kubernetes local
            ├── namespace spark
            │   ├── Spark Operator
            │   ├── SparkApplication
            │   ├── Spark driver pod
            │   └── Spark executor pods
            └── namespace storage
                └── almacenamiento S3 local

## Componentes

- Docker: ejecucion de contenedores.
- kind: crea un clúster Kubernetes local usando contenedores Docker como nodos.
- kubectl: cliente para administrar clusters de kubernetes.
- Helm: instalador de aplicaciones Kubernetes.
- Spark Operator: operador que permite ejecutar Spark mediante recursos SparkApplication.
- S3 local: almacenamiento de objetos local para evitar montar carpetas del host dentro del clúster.

## Principio de diseño

No se montarán directorios locales del host en los pods Spark como mecanismo principal.

Los datos de entrada y salida deberán ir a un almacenamiento S3 local compatible, para aproximar el laboratorio a una arquitectura cloud/lakehouse real sin depender de Azure, AWS o GCP.
