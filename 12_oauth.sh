oc get oauth cluster -o yaml > orig_oauth.yaml
cat << EOF >> orig_oauth.yaml
  - type: OpenID
    name: oidcidp
    mappingMethod: add
    openID:
      ca:
        name: keycloak-ca
      claims:
        email:
        - custom_email_claim
        - email
        groups:
        - groups
        name:
        - nickname
        - given_name
        - name
        preferredUsername:
        - preferred_username
        - email
      clientID: openshift
      clientSecret:
        name: ocpclient
      extraAuthorizeParameters:
        include_granted_scopes: "true"
      extraScopes:
      - email
      - profile
      issuer: $KEYCLOAK_URL/auth/realms/master
EOF

oc apply -f orig_oauth.yaml
