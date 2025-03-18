KEY_CLIENTSECRET=$(curl -X GET -k -H "Authorization: Bearer $KEYCLOAKTOKEN" $KEYCLOAK_URL/auth/admin/realms/master/clients/$KEY_CLIENTID/client-secret | jq -r '.value')
 	  
oc create secret generic ocpclient --from-literal=clientSecret=$KEY_CLIENTSECRET -n openshift-config

oc create configmap --from-file=ca.crt=certificate.pem -n openshift-config keycloak-ca

