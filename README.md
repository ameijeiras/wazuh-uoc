# Despliegue de wazuh sobre cluster de Kubernetes basado en Amazon EKS


Despliegue de un cluster del SIEM Wazuh sobre un entorno de Kubernetes implementado en Amazon EKS

## Architecture
![Imagen de la arquitectura](https://github.com/ameijeiras/wazuh-uoc/blob/main/recursos/ArquitecturaTFMV1.drawio.png?raw=true)

## Documentation

 [instructions.md](instructions.md) 

## Directory structure

[Tree]

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


