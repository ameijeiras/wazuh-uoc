# Despliegue de wazuh sobre cluster de Kubernetes basado en Amazon EKS


Despliegue de un cluster del SIEM Wazuh sobre un entorno de Kubernetes implementado en Amazon EKS

## Arquitectura
![Imagen de la arquitectura](https://github.com/ameijeiras/wazuh-uoc/blob/main/recursos/ArquitecturaTFMV1.drawio.png?raw=true)

## Documentación

 [instructions.md](instructions.md) 

## Estructura de directorios
```
.
├── CHANGELOG.md
├── LICENSE
├── quickstart
│   ├── 1Namespace.yaml
│   ├── 2Storage.yaml
│   ├── 3Data.yaml
│   ├── 5Services.yaml
│   ├── 6Kibana.yaml
│   ├── 7Elastic.yaml
│   ├── 8WazuhManager.yaml
│   ├── 9WazuhWorker.yaml
│   └── todo.yaml
├── README.md
├── recursos
│   ├── ArquitecturaTFMV1.drawio.png
│   └── Portada.png
├── VERSION
├── wazuh
│   ├── base
│   │   ├── storage-class.yaml
│   │   └── wazuh-ns.yaml
│   ├── certs
│   │   ├── kibana_http
│   │   │   └── generate_certs.sh
│   │   └── odfe_cluster
│   │       └── generate_certs.sh
│   ├── elastic_stack
│   │   ├── elasticsearch
│   │   │   ├── cluster
│   │   │   │   ├── elasticsearch-api-svc.yaml
│   │   │   │   └── elasticsearch-sts.yaml
│   │   │   ├── elastic_conf
│   │   │   │   ├── elasticsearch.yml
│   │   │   │   └── internal_users.yml
│   │   │   └── elasticsearch-svc.yaml
│   │   └── kibana
│   │       ├── kibana-deploy.yaml
│   │       └── kibana-svc.yaml
│   ├── kustomization.yml
│   ├── secrets
│   │   ├── elastic-cred-secret.yaml
│   │   ├── wazuh-api-cred-secret.yaml
│   │   ├── wazuh-authd-pass-secret.yaml
│   │   └── wazuh-cluster-key-secret.yaml
│   └── wazuh_managers
│       ├── wazuh-cluster-svc.yaml
│       ├── wazuh_conf
│       │   ├── master.conf
│       │   └── worker.conf
│       ├── wazuh-master-sts.yaml
│       ├── wazuh-master-svc.yaml
│       ├── wazuh-workers-svc.yaml
│       └── wazuh-worker-sts.yaml
```

> **_NOTE:_**  Nota


## Branches

* La rama `main` contiene la última versión del código.


## Despligue
Existen dos formas de desplegar el entorno Wazuh sobre un cluster Kubernetes dentro del servicio Amazon EKS.
En ambos casos, es necesario disponer previamente de de un entorno EKS con AWS cli y kubectl instalado en el equipo desde el que se vaya a realizar el despliegue.
### Despliegue Rápido
Este es el modo de despligue para impacientes. Se incluyen los ficheros de configuración de API de kubernetes preparados para un despliegue rapido. Se incluyen embebidos los certificados y datos de configuración necesarios que un despliegue rápido. Se incluyen por defecto en la configuración 2 nodos workers de wazuh y 2 nodos de elastic.
```
git clone https://github.com/ameijeiras/wazuh-uoc.git
cd quickstart
kubbectl apply -d todo.yaml
```

### Despliegue manual
Este es el modo de despligue manual. En primer lugar es necesario crear los certificados que se van a emplear para securizar las comunicaciones de los distintos sistemas. A continuación, a través del fichero kustomize.yaml podemos ajustar la configuración del despligue (nodos, afinidad, recursos por servicio, etc) en función de nuestra necesidades.
```
git clone https://github.com/ameijeiras/wazuh-uoc.git
cd wazuh-uoc/wazuh/
./certs/kibana_http/generate_certs.sh
./certs/odfe_cluster/generate_certs.sh 
kubectl apply -k .
```

## Credits and Thank you

Basado en el trabajo previo del modelo de despliegue de Wazuh Inc. (https://github.com/wazuh/wazuh-kubernetes.git Branch v4.2.5)

## License and copyright

angel[@]ameijeiras[.]es
Copyright (C) 2021 angel[@]ameijeiras[.]es  (License GPLv2)

## References

https://github.com/wazuh/wazuh-kubernetes.git
