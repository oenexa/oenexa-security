# OENEXA Security & Compliance Governance (`oenexa-security`)

> **Enterprise Zero-Trust Security, Compliance Baselines & DevSecOps Repository**  
> Governed by the OENEXA Chief Information Security Officer (CISO) & DevSecOps Teams.

## 1. Zero-Trust Security Standards
- **OWASP ASVS v4.0.3**: Level 3 controls across all services.
- **OWASP Top 10 API Security**: Authentication, authorization, rate limiting, and input validation.
- **PCI-DSS SAQ-D**: Tokenized credit card processing via isolated payment rail.
- **SOC 2 Type II**: Security, Availability, and Confidentiality trust principles.
- **GDPR**: Right to be forgotten, zero-knowledge encryption of PII at rest and in transit.

## 2. Directory Layout
```text
oenexa-security/
├── policies/
│   └── opa/container-security.rego     # OPA Gatekeeper Admission Policies
├── vault/
│   └── policies/service-policy.hcl     # Vault Least-Privilege Domain Token Policies
├── compliance/
│   └── soc2-iso27001-matrix.md         # Compliance Controls & Audit Evidence
└── playbooks/
    └── sev1-incident-response.md       # SRE & Security Incident Playbooks
```
