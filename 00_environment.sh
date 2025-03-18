KEYCLOAK_ROUTE=`oc whoami --show-console | sed -e s/"https:\/\/console-openshift-console"/keycloak-keycloak/g `
KEYCLOAK_URL=`oc whoami --show-console | sed -e s/"console-openshift-console"/keycloak-keycloak/g`



