# OENEXA SEV-1 Incident Response Playbook

## 1. Severity Classification
- **SEV-1 (Critical)**: Total outage of core portal (`app.oenexa.com`), auth (`id.oenexa.com`), wallet fund drainage risk, or L1 consensus halt.
- **Response Time**: < 5 minutes 24/7/365. Incident Commander appointed immediately.

## 2. Emergency Kill-Switches
If an unauthorized transaction pattern, double-spend, or credential leak is detected:
1. **Wallet Withdrawal Freeze**:
   ```bash
   curl -X POST https://api.oenexa.com/internal/v1/emergency/wallet-freeze \
     -H "X-Security-Auth: $VAULT_SECURITY_TOKEN"
   ```
2. **Global Session Invalidation**:
   ```bash
   curl -X POST https://id.oenexa.com/internal/v1/sessions/revoke-all-active \
     -H "X-Security-Auth: $VAULT_SECURITY_TOKEN"
   ```

## 3. Communication Protocol
- Internal: `#war-room-sev1` Slack / Signal Bridge.
- External: Real-time updates posted to `https://status.oenexa.com` within 15 minutes.
- Blameless Post-Mortem required within 48 hours with published timeline and preventative action items.
