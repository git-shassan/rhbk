echo "checking if ouath configured...."
oc get authentication.operator.openshift.io cluster -o json | jq ".spec.observedConfig.oauthServer.oauthConfig.identityProviders[] | {name: .name, kind: .provider.kind }"
echo "checking for errors...."
oc get authentication.operator.openshift.io cluster -o json | jq '.status.conditions[] | select(.reason =="Error")'


OAUTH_POD=$(oc get pods -n openshift-authentication | grep oauth-openshift | awk '{print $1}'| head -1)
oc wait --for=condition=Ready -n openshift-authentication pod/$OAUTH_POD

echo "Checking if operator is ready..."
oc wait --for=jsonpath='{.status.conditions[?(@.type=="Available")].status}'="True" co authentication

echo "############ all done ###########"
echo -n "Keycloak Initial User:"
echo $KEYCLOAKADMIN
echo -n "Password:"
echo $KEYCLOAKADMINPASSWD
echo -n "Keycloak URL:"
echo $KEYCLOAK_URL
