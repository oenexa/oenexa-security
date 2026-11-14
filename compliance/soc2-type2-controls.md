# SOC 2 Type II Security Controls & Audit Framework

**Classification**: Confidential / OENEXA Enterprise Security Standard  
**Governing Standard**: AICPA Trust Services Criteria (TSC) 2017  

---

## 1. Common Criteria (CC) Security Controls

### CC6.1 Logical Access Controls
- **Control**: All human access to production systems requires hardware-backed WebAuthn/FIDO2 MFA via `id.oenexa.com`.
- **Enforcement**: IAM policies mandate Passkey or TOTP with mandatory 90-day key rotation and instantaneous offboarding revoking active session refresh tokens.

### CC6.3 Least Privilege Access
- **Control**: Role-Based Access Control (RBAC) and Attribute-Based Access Control (ABAC) enforced on all administrative endpoints.
- **Enforcement**: Zero developer access to production databases. Read-only break-glass access granted only via ephemeral, audited 2-hour Vault tokens signed by the Security Officer.

### CC6.6 Boundary Protection
- **Control**: Multi-tiered network segmentation with strict egress and ingress firewall rules.
- **Enforcement**: Cloudflare Edge WAF, Caddy mutual TLS, and Kubernetes NetworkPolicies blocking cross-namespace traffic unless explicitly permitted.

---

## 2. Processing Integrity (PI) Controls

### PI1.1 Data Validation & Idempotency
- **Control**: All financial transactions and order placements require an `Idempotency-Key` and RFC 7807 problem details validation.
- **Enforcement**: Middleware validates duplicate transaction keys within a 24-hour Redis TTL window, rejecting double-execution attempts.

### PI1.2 Ledger Balance Verification
- **Control**: Double-entry bookkeeping guarantees that total debits equal total credits across all accounts.
- **Enforcement**: Automated continuous reconciliation daemon checks zero-sum ledger invariants every 60 seconds.
