# GDPR Data Sovereignty & Cryptographic Shredding Architecture

**Classification**: Confidential / OENEXA Enterprise Privacy Standard  
**Governing Regulation**: EU General Data Protection Regulation (GDPR) 2016/679  

---

## 1. Principles of Data Minimization & Sovereignty

All Personally Identifiable Information (PII) is encrypted at rest using AES-256-GCM. Personal data is never stored in unencrypted application caches or plain text logs.

---

## 2. Right to Erasure (Cryptographic Shredding)

Blockchain ledgers and immutable consensus state cannot be mutated by design. To guarantee full GDPR Article 17 compliance:

1. **Per-User Encryption Key Separation**: Every user's off-chain PII (full name, phone, residential address, KYC documents) is encrypted with a distinct customer-specific data encryption key (CDEK).
2. **Key Storage**: CDEKs are maintained exclusively inside HashiCorp Vault with an audit trail.
3. **Erasure Execution (Cryptographic Shredding)**:
   - When a user submits an erasure request, the CDEK is purged and cryptographically zeroized from Vault.
   - All historical records in backups, ledgers, and data lakes become mathematically unrecoverable ciphertext, fulfilling the legal standard of permanent deletion without breaking blockchain hash chains.

---

## 3. Data Residency & Cross-Border Transfers
- European citizen data is held exclusively in EU availability zones (`eu-central-1` Frankfurt / `eu-west-1` Dublin).
- No unencrypted PII is ever transmitted to non-EU jurisdictions.
