# OENEXA Enterprise HashiCorp Vault Policy
# Multi-tenant zero-trust secret leasing policy for microservices

# Read-only access to service-specific KV v2 secrets
path "secret/data/oenexa/{{identity.entity.metadata.service_name}}/*" {
  capabilities = ["read"]
}

# Dynamic database credential generation with automated lease expiration
path "database/creds/{{identity.entity.metadata.service_name}}-role" {
  capabilities = ["read"]
}

# Automated TLS certificate issuance via internal Vault PKI CA
path "pki_int/issue/oenexa-dot-internal" {
  capabilities = ["create", "update"]
  allowed_parameters = {
    "common_name" = ["*.oenexa.internal", "{{identity.entity.metadata.service_name}}.oenexa.internal"]
    "ttl"         = ["720h"]
  }
}

# Transit secrets engine for cryptographic token and data-at-rest encryption
path "transit/encrypt/{{identity.entity.metadata.service_name}}" {
  capabilities = ["update"]
}

path "transit/decrypt/{{identity.entity.metadata.service_name}}" {
  capabilities = ["update"]
}

# Revocation and lease renewal
path "sys/leases/renew" {
  capabilities = ["update"]
}
