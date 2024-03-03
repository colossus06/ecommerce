# Week IV-Multi Cluster Deployment-ArgoCD

Setup Argocd using helm

```sh
./install-helm.sh
```

![](images/20240302010459.png)


**Setup ArgoCD http mode**

```sh
k get cm -n argocd
k edit cm -n argocd argocd-cmd-params-cm
```

Add the following entry:

```sh
data:
  server.insecure: "true"
```

![](images/20240302005719.png)

Convert the server type from ClusterIP to NodePort

```sh
k edit svc argocd-server -n argocd
```


Connect SCM and ArgoCD

```sh
k get secret -n argocd
k get secret argocd-initial-admin-secret -n argocd -oyaml
echo <secret> | base64 -d
k get no -owide
```
### Allowing argocd-server inbound port from your ip

Open your vmss, instances and instance, network settings, add inbound port rule:

![](images/20240302011624.png)

`destination port: argo-server-http port`

Access the argocd ui using the <node-ip> and the <http-port> 

`80:32688/TCP,443:32400/TCP`


![](images/20240302011931.png)

`username: admin` and paste the admin password you got in the previous step.


**Local port forwarding**

```sh
k port-forward -n argocd argocd-server
k port-forward svc/frontend-external 8085:80
```

### Connect ArgoCD with the AKS Cluster

Create a manifest file 

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-private-https-repo
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  type: git
  url: <release-manifests-repo-url>
  password: <pat>
  username: <github-username>
```

k apply -f repo-secret.yaml


![](images/20240302014231.png)

### Creating an app

`vim app.yaml`

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: devops
  namespace: argocd
spec:
  destination:
    namespace: default
    server: 'https://kubernetes.default.svc'
  source:
    path: ./
    repoURL: 'https://github.com/colossus06/microservices-release'
    targetRevision: master
  sources: []
  project: default
  syncPolicy:
    automated:
      prune: false
      selfHeal: false
```


## pulling images from ACR private registry:


kubectl create secret docker-registry <secret-name> \
  --namespace <namespace> \
  --docker-server=<container-registry-name>.azurecr.io \
  --docker-username=<service-principal-ID> \
  --docker-password=<service-principal-password>


Adding image pull secret on the manifest files:

```yaml
imagePullSecrets:
- name: acr-secret
```

## Verifying that argocd picks up the new changes:

![](images/20240302212905.png)

## Validation



