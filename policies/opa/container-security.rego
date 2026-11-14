package kubernetes.admission

default allow = false

# Violation: Privileged containers are strictly forbidden
violation[{"msg": msg}] {
    container := input.request.object.spec.template.spec.containers[_]
    container.securityContext.privileged == true
    msg := sprintf("Container '%v' cannot run in privileged mode (SOC2 / PCI-DSS compliance).", [container.name])
}

# Violation: Root execution is forbidden
violation[{"msg": msg}] {
    podSpec := input.request.object.spec.template.spec
    not podSpec.securityContext.runAsNonRoot == true
    msg := "Pods must declare 'securityContext.runAsNonRoot: true'."
}

# Violation: Immutable image tag required (no :latest)
violation[{"msg": msg}] {
    container := input.request.object.spec.template.spec.containers[_]
    endswith(container.image, ":latest")
    msg := sprintf("Container '%v' uses disallowed ':latest' image tag. Pinned semantic version or SHA256 digest is required.", [container.name])
}

# Violation: Mandatory resource limits
violation[{"msg": msg}] {
    container := input.request.object.spec.template.spec.containers[_]
    not container.resources.limits.memory
    msg := sprintf("Container '%v' missing mandatory memory limit.", [container.name])
}

allow {
    count(violation) == 0
}
