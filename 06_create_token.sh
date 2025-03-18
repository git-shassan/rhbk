
#Create Token
KEYCLOAKTOKEN=`curl -k -d "client_id=admin-cli" -d "username=$KEYCLOAKADMIN" -d "password=$KEYCLOAKADMINPASSWD" -d "grant_type=password" "$KEYCLOAK_URL/auth/realms/master/protocol/openid-connect/token" |   jq -r '.access_token'`

#29 min token validity
curl -k --header 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAKTOKEN" -X PUT $KEYCLOAK_URL/auth/admin/realms/master -d '{"accessTokenLifespan":1740}'

