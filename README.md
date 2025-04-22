
# Desplegar Microservicio en AKS

## 1. Obtener las credenciales de AKS

```bash
az aks get-credentials --resource-group rg-camilsoft-dev --name camilsoft-aks-dev
```

## 2. Clonar el repositorio e ingresar a la carpeta del proyecto

```bash
git clone https://github.com/Camilsoft-Software/integration-service.git
cd integration-service
```

## 3. Aplicar el manifiesto del servicio al clúster AKS

```bash
kubectl apply -f deploy/service.yaml
kubectl get service
```

### Resultado esperado:

| NAME                | TYPE          | CLUSTER-IP     | EXTERNAL-IP    | PORT(S)         | AGE  |
|---------------------|---------------|----------------|----------------|-----------------|------|
| integration-service  | LoadBalancer  | 10.0.182.233   | 172.212.50.32  | 80:32425/TCP    | 11s  |

## 4. Aplicar el manifiesto del deployment al clúster AKS

```bash
kubectl apply -f deploy/deployment.yaml
kubectl get deployments
kubectl get pods
```

### Resultado esperado:

| NAME                | READY   | UP-TO-DATE | AVAILABLE | AGE    |
|---------------------|---------|------------|-----------|--------|
| integration-service  | 1/1     | 1          | 1         | 5d3h   |

| NAME                                   | READY   | STATUS  | RESTARTS | AGE    |
|----------------------------------------|---------|---------|----------|--------|
| integration-service-7fdd85687c-bbnll   | 1/1     | Running | 0        | 5d2h   |

Validar el acceso:

- [http://172.212.50.32/hola](http://172.212.50.32/hola)
- [https://camilsoft-apim.azure-api.net/integration](https://camilsoft-apim.azure-api.net/integration)

---

## 5. Eliminar un Pod

```bash
kubectl delete pod integration-service-7fdd85687c-5t6sg
```

---

## 6. Construir una imagen Docker en Azure Container Registry (ACR) a partir de GitHub

```bash
az acr build --registry camilsoftacr --image integration-service:latest https://github.com/Camilsoft-Software/integration-service.git
```

## 7. Autorizar AKS a acceder al ACR

```bash
az aks update -n camilsoft-aks-dev -g rg-camilsoft-dev --attach-acr camilsoftacr
```

## 8. Ver la estructura de la carpeta y archivos

```bash
ls -R
```

Para ver el contenido del archivo `service.yaml`:

```bash
nano service.yaml
```

---

### Comandos útiles:

- **ls -R**: Ver la estructura de la carpeta y archivos
- **nano service.yaml**: Ver el contenido del archivo
- **Ctrl + O**: Guardar archivo
- **Ctrl + X**: Salir de `nano`

---

### Notas:

- Asegúrate de que los puertos (`targetPort`, `server.port`) sean consistentes entre tus archivos de configuración para evitar errores.
