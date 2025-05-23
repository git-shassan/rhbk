cat << EOF | oc apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: keycloak
  annotations:
    workload.openshift.io/allowed: management
---
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: keycloak
  namespace: keycloak 
spec:
  targetNamespaces:
  - keycloak
---
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: redhat-keycloak-operator-subscription
  namespace: keycloak
spec:
  channel: "stable-v26.0"
  name: rhbk-operator 
  source: redhat-operators
  sourceNamespace: openshift-marketplace
EOF
