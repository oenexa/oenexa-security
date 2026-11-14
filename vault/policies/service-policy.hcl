# HashiCorp Vault Least-Privilege Policy for OENEXA Microservices
# Ensures a service can only read secrets inside its own domain path.

# Allow reading own domain secrets
path "secret/data/oenexa/{{identity.entity.metadata.domain}}/*" {
  capabilities = ["read", "list"]
}

# Deny all cross-domain secrets explicitly
path "secret/data/oenexa/+/admin/*" {
  capabilities = ["deny"]
}

# Allow renewing own dynamic lease
path "auth/token/renew-self" {
  capabilities = ["update"]
}
