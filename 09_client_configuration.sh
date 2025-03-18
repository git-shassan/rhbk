KEY_CONSOLE=$(oc whoami --show-console)
KEY_OAUTH=$(oc get routes -n openshift-authentication oauth-openshift -o jsonpath='{.status.ingress[].host}')

#create client
curl -X POST -k --header 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAKTOKEN" $KEYCLOAK_URL/auth/admin/realms/master/clients -d '{"protocol":"openid-connect","clientId":"openshift","name":"ocp","description":"","publicClient":false,"authorizationServicesEnabled":false,"serviceAccountsEnabled":false,"implicitFlowEnabled":false,"directAccessGrantsEnabled":true,"standardFlowEnabled":true,"frontchannelLogout":true,"attributes":{"saml_idp_initiated_sso_url_name":"","oauth2.device.authorization.grant.enabled":false,"oidc.ciba.grant.enabled":false,"post.logout.redirect.uris":"'$KEY_CONSOLE'/*"},"alwaysDisplayInConsole":false,"rootUrl":"'$KEY_CONSOLE'","baseUrl":"'$KEY_CONSOLE'","redirectUris":["https://'$KEY_OAUTH'/*"]}'


#get client id from client name
KEY_CLIENTID=$(curl -X GET -k --header 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAKTOKEN" $KEYCLOAK_URL/auth/admin/realms/master/clients | jq -r -c '.[] | select(.clientId== "openshift")| .id')

#client protocol mapper 
curl -X POST -k --header 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAKTOKEN" $KEYCLOAK_URL/auth/admin/realms/master/clients/$KEY_CLIENTID/protocol-mappers/models --data-raw '{"protocol":"openid-connect","protocolMapper":"oidc-group-membership-mapper","name":"groups","config":{"claim.name":"groups","full.path":"false","id.token.claim":"true","access.token.claim":"true","lightweight.claim":"false","userinfo.token.claim":"true","introspection.token.claim":"true"}}'

