openssl req -subj '/CN='$KEYCLOAK_ROUTE'/O=Test Keycloak./C=US' -addext 'subjectAltName = DNS:'$KEYCLOAK_ROUTE -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem
sleep 10
oc create secret tls -n keycloak keycloak-tls-secret --cert certificate.pem --key key.pem
