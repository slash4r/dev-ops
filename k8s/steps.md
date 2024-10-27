## WorkShop 1: Basic Minikube Setup and First Pod

1. Install Minikube locally:
   ```bash
   winget install Kubernetes.minikube
   ```

2. Start Minikube in PowerShell (downloads necessary packages):
   ```bash
   minikube start
   ```

3. Create your first pod with Nginx:
   ```bash
   kubectl run firstpod --image=nginx
   ```

4. Check the status and details of the pods:
   ```bash
   kubectl get pods -o wide
   kubectl describe pods firstpod
   kubectl logs firstpod
   ```

5. Follow logs in real-time:
   ```bash
   kubectl logs -f firstpod
   ```

6. Execute commands inside the pod:
   ```bash
   kubectl exec firstpod -- ls
   kubectl exec -it firstpod -- bash
   ```

7. Delete the pod:
   ```bash
   kubectl delete pods firstpod
   ```

### Screenshots

![k8s1.jpg](screenshots%2Fk8s1.jpg)
![k8s11.jpg](screenshots%2Fk8s11.jpg)
![k8s111.jpg](screenshots%2Fk8s111.jpg)

---

## WorkShop 2: Working with YAML Configurations

1. Create and apply `pod1.yaml`:
   ```bash
   kubectl apply -f pod1.yaml
   ```

### Screenshots

![k8s2.jpg](screenshots%2Fk8s2.jpg)

---

## WorkShop 3: Multi-Container Pods

1. Create and apply `multicontainer.yaml`:
   ```bash
   kubectl apply -f multicontainer.yaml
   kubectl get pods
   ```

2. Connect to `webcontainer` and install `net-tools` to show the Ethernet interface:
   ```bash
   kubectl exec -it multicontainer -c webcontainer -- /bin/sh
   apt update
   apt install net-tools
   ifconfig
   ```

3. Connect to `sidecarcontainer` and check volume:
   ```bash
   kubectl exec -it multicontainer -c sidecarcontainer -- /bin/sh
   ls /var/logs
   ```

4. Follow logs of `sidecarcontainer`:
   ```bash
   kubectl logs -f multicontainer -c sidecarcontainer
   ```

5. Forward the port of the pod to the host:
   ```bash
   kubectl port-forward pod/multicontainer 8080:80
   ```

### Screenshots

![k8s3.jpg](screenshots%2Fk8s3.jpg)
![k8s33.jpg](screenshots%2Fk8s33.jpg)
![k8s333.jpg](screenshots%2Fk8s333.jpg)
![k8s3333.jpg](screenshots%2Fk8s3333.jpg)

---

## WorkShop 4: Deployments and Scaling

1. Create and apply `deployment1.yaml`:
   ```bash
   kubectl apply -f deployment1.yaml
   ```

2. Check the deployment result:
   ```bash
   kubectl get pods
   ```

3. Delete a pod to see automatic recreation by Kubernetes:
   ```bash
   kubectl delete pods firstdeployment-65d978c499-7vzhw
   kubectl get pods
   ```

4. Scale up to 5 replicas:
   ```bash
   kubectl scale deployments firstdeployment --replicas=5
   ```

5. Scale down to 3 replicas:
   ```bash
   kubectl scale deployments firstdeployment --replicas=3
   ```

6. Connect to one of the pods and check network interfaces:
   ```bash
   kubectl exec -it firstdeployment-65d978c499-6rjzw -- bash
   apt update
   apt install net-tools
   ifconfig
   ```

7. Port-forward from one of the pods to host:
   ```bash
   kubectl port-forward firstdeployment-65d978c499-6rjzw 8085:80
   ```

### Screenshots

![k8s4.jpg](screenshots%2Fk8s4.jpg)
![k8s44.jpg](screenshots%2Fk8s44.jpg)
![k8s444.jpg](screenshots%2Fk8s444.jpg)

---

## WorkShop 5: Rollouts and Rollbacks

1. Create `recreate-deployment.yaml` and `rolling-deployment.yaml`.

2. Apply `recreate-deployment.yaml`:
   ```bash
   kubectl apply -f recreate-deployment.yaml
   ```

3. Watch the status of replicas and pods:
   ```bash
   kubectl get pods -w
   kubectl get rs -w
   ```

4. Update image version:
   ```bash
   kubectl set image deployment rcdeployment nginx=httpd
   ```

5. Apply `rolling-deployment.yaml` and update configuration:
   ```bash
   kubectl apply -f rolling-deployment.yaml
   kubectl edit deployment rolldeployment --record
   ```

6. Set new image version with `--record` to track deployment history:
   ```bash
   kubectl set image deployment rolldeployment nginx=httpd:alpine --record=true
   ```

7. Show deployment history:
   ```bash
   kubectl rollout history deployment rolldeployment
   kubectl rollout history deployment rolldeployment --revision=1
   ```

8. Roll back to revision 1:
   ```bash
   kubectl rollout undo deployment rolldeployment --to-revision=1
   ```

9. Check rollout status:
   ```bash
   kubectl rollout status deployment rolldeployment -w
   ```

10. Delete the deployment:
   ```bash
   kubectl delete -f rolling-deployment.yaml
   ```

### Screenshots

![k8s555.jpg](screenshots%2Fk8s555.jpg)
![k8s55.jpg](screenshots%2Fk8s55.jpg)
![k8s5.jpg](screenshots%2Fk8s5.jpg)