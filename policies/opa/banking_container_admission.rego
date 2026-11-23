package oenexa.banking.admission

import future.keywords.in

default allow = false

# 1. Require Non-Root Execution
allow {
    input.request.kind.kind == "Pod"
    container := input.request.object.spec.containers[_]
    container.securityContext.runAsNonRoot == true
    container.securityContext.allowPrivilegeEscalation == false
    container.securityContext.readOnlyRootFilesystem == true
    not container_uses_privileged_capabilities(container)
}

# 2. Block Privileged Capabilities
container_uses_privileged_capabilities(container) {
    cap := container.securityContext.capabilities.add[_]
    cap in ["SYS_ADMIN", "NET_ADMIN", "ALL"]
}

# 3. Deny Any Unsigned Images or Latest Tags in Production
violation[msg] {
    container := input.request.object.spec.containers[_]
    endswith(container.image, ":latest")
    msg := sprintf("Production Admission Error: Image %v uses mutable ':latest' tag.", [container.image])
}

violation[msg] {
    container := input.request.object.spec.containers[_]
    not startswith(container.image, "ghcr.io/oenexa/")
    not startswith(container.image, "cgr.dev/chainguard/")
    msg := sprintf("Security Violation: Image %v must originate from verified registry.", [container.image])
}

# 4. Mandatory Resource Limits
violation[msg] {
    container := input.request.object.spec.containers[_]
    not container.resources.limits.memory
    msg := sprintf("Resource Policy: Container %v missing memory limit.", [container.name])
}
