# assumes that a group by name of keycloakgroup2 exists 
curl -X POST -k --header 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAKTOKEN" $KEYCLOAK_URL/auth/admin/realms/master/users -d '{"username":"syed_4","firstName":"Syed","lastName":"Hassan","credentials":[{"type":"password","value":"test12345"}],"enabled":"true"}'

#get user id of a username
KEY_USERID=$(curl -X GET -k --header 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAKTOKEN" $KEYCLOAK_URL/auth/admin/realms/master/users | jq -r -c '.[] | select(.username == "syed_4")| .id')

#get group id from group name
KEY_GROUPID=$(curl -X GET -k --header 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAKTOKEN" $KEYCLOAK_URL/auth/admin/realms/master/groups | jq -r -c '.[] | select(.name == "keycloakgroup2")| .id')

#Link user to a group membership
curl -X PUT -k --header 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAKTOKEN" $KEYCLOAK_URL/auth/admin/realms/master/users/$KEY_USERID/groups/$KEY_GROUPID

