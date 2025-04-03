## Steps to install and configure Red Hat Build of key cloak (RHBK)
Accoumpanying slides posted [here](https://cloudify.network/slides/installing_configuring_rhbk.pdf)

## Tips:

A default admin user can be configured by first creating that user/secret by:
`oc create secret generic keycloak-bootstrap-admin --from-literal=username=admin --from-literal=password=test12345 -n keycloak` 

and then pointing to that secret in the file [05_kc_instance.sh](https://github.com/git-shassan/rhbk/blob/main/05_kc_instance.sh) as shown here:  

```
spec:
  bootstrapAdmin:
    user:
      secret: keycloak-bootstrap-admin
```
