cat << EOF | oc apply -f - 
apiVersion: v1
data:
  # echo -n testpassword | base64
  # dGVzdHBhc3N3b3Jk
  # echo -n testuser | base64
  # dGVzdHVzZXI=
  password: dGVzdHBhc3N3b3Jk
  username: dGVzdHVzZXI=
kind: Secret
metadata:
  name: keycloak-db-secret
  namespace: keycloak
type: Opaque
EOF
