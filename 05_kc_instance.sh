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

sleep 60
KEYCLOAKADMIN=`oc get secret example-kc-initial-admin -o jsonpath='{.data.username}' | base64 --decode`
KEYCLOAKADMINPASSWD=`oc get secret example-kc-initial-admin -o jsonpath='{.data.password}' | base64 --decode
