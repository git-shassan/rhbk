cat << EOF > keycloak.yaml
apiVersion: k8s.keycloak.org/v2alpha1
kind: Keycloak
metadata:
  name: example-kc
  namespace: keycloak
spec:
  db:
    host: postgres-db
    passwordSecret:
      key: password
      name: keycloak-db-secret
    usernameSecret:
      key: username
      name: keycloak-db-secret
    vendor: postgres
  hostname:
    hostname: KEYCLOAK_ROUTE
  http:
    tlsSecret: keycloak-tls-secret
  ingress:
    className: openshift-default
  instances: 1
  proxy:
    headers: xforwarded
  additionalOptions:
    - name: http-relative-path
      value: /auth 
EOF

cat keycloak.yaml | sed -e s/KEYCLOAK_ROUTE/$KEYCLOAK_ROUTE/g | oc apply -f -
echo "Waiting for keycloak pod to be ready..."
while ! oc wait -n keycloak --for=condition=Ready pod/example-kc-0; do echo "Waiting for keycloak pod to be ready..."; oc get pod example-kc-0 -n keycloak; sleep 10; done
KEYCLOAKADMIN=`oc get secret -n keycloak example-kc-initial-admin -o jsonpath='{.data.username}' | base64 --decode`
KEYCLOAKADMINPASSWD=`oc get secret -n keycloak example-kc-initial-admin -o jsonpath='{.data.password}' | base64 --decode`
