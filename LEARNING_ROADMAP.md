# 🎓 Learning Roadmap

A comprehensive guide to learning DevOps, Cloud-Native, and Kubernetes technologies. This document serves as a tracking tool to organize learning objectives and resources.

---

## 📚 Table of Contents

- [Local Cloud / Edge](#local-cloud--edge)
- [Kubernetes (K8s)](#kubernetes-k8s)
- [ArgoCD](#argocd)
- [Container & Docker](#container--docker)
- [CI/CD](#cicd)
- [Monitoring & Logging](#monitoring--logging)
- [Infrastructure as Code](#infrastructure-as-code)
- [Advanced Topics](#advanced-topics)

---

## 🌐 Local Cloud / Edge

Local cloud platforms and edge computing technologies for running cloud-native applications locally.

### Floci
- **Status**: 📝 To Learn
- **Resource**: [Floci Installation](https://floci.io/#install)
- **Description**: Local cloud platform for edge computing
- **Topics to Cover**:
  - [ ] Installation and setup
  - [ ] Basic concepts
  - [ ] Running containers
  - [ ] Networking

### Kind (Kubernetes in Docker)
- **Status**: ✅ In Progress
- **Resource**: [Kind Documentation](https://kind.sigs.k8s.io/)
- **Description**: Lightweight Kubernetes cluster for local development
- **Topics to Cover**:
  - [x] Installation
  - [x] Creating clusters
  - [ ] Multi-node cluster setup
  - [ ] Persistence volumes
  - [ ] Ingress configuration

### Minikube
- **Status**: 📝 To Learn
- **Resource**: [Minikube Documentation](https://minikube.sigs.k8s.io/)
- **Description**: Local Kubernetes cluster runner
- **Topics to Cover**:
  - [ ] Installation
  - [ ] Cluster creation
  - [ ] Add-ons and extensions

---

## ☸️ Kubernetes (K8s)

Container orchestration platform for managing containerized applications.

### Core Concepts
- **Status**: ✅ Learning
- **Topics to Cover**:
  - [x] Namespace
  - [x] Pod
  - [x] Deployment
  - [x] ReplicaSet
  - [x] Service (ClusterIP, NodePort, LoadBalancer)
  - [ ] StatefulSet
  - [ ] DaemonSet
  - [ ] Job & CronJob
  - [ ] ConfigMap
  - [ ] Secret
  - [ ] Volume & PersistentVolume (PV)
  - [ ] PersistentVolumeClaim (PVC)
  - [ ] Ingress
  - [ ] RBAC (Role-Based Access Control)
  - [ ] ServiceAccount

### Networking
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Service DNS resolution
  - [ ] Network policies
  - [ ] Ingress controllers
  - [ ] Load balancing
  - [ ] Multi-cluster networking

### Storage
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Persistent Volumes (PV)
  - [ ] Storage Classes
  - [ ] Persistent Volume Claims (PVC)
  - [ ] Dynamic provisioning
  - [ ] Backup and restore

### Operators
- **Status**: 📝 To Learn
- **Resources**: [Kubernetes Operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/)
- **Topics to Cover**:
  - [ ] Operator pattern
  - [ ] Custom Resource Definitions (CRD)
  - [ ] Building operators

### Helm
- **Status**: 📝 To Learn
- **Resource**: [Helm Documentation](https://helm.sh/)
- **Description**: Package manager for Kubernetes
- **Topics to Cover**:
  - [ ] Installation
  - [ ] Charts basics
  - [ ] Installing charts
  - [ ] Creating custom charts
  - [ ] Values and templating

### kubectl CLI
- **Status**: ✅ In Progress
- **Resource**: [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- **Topics to Cover**:
  - [x] Common commands (get, describe, apply, delete)
  - [x] Port forwarding
  - [x] Logs and exec
  - [ ] Advanced querying (JSONPath)
  - [ ] Debugging commands
  - [ ] Performance troubleshooting

### Troubleshooting & Debugging
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Pod debugging
  - [ ] Resource limits issues
  - [ ] Networking issues
  - [ ] Storage issues
  - [ ] Using debug containers

---

## 🔄 ArgoCD

GitOps tool for declarative, continuous deployment to Kubernetes.

### Getting Started
- **Status**: 📝 To Learn
- **Resource**: [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- **Topics to Cover**:
  - [ ] Installation
  - [ ] UI/CLI access
  - [ ] Basic concepts (Application, Repository, Sync)

### Core Concepts
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Applications
  - [ ] Repositories (Git)
  - [ ] Sync strategies (Auto/Manual)
  - [ ] Health assessment
  - [ ] Notifications & alerts

### Integration
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Git repository setup
  - [ ] Webhook configuration
  - [ ] Multi-cluster deployment
  - [ ] Authentication (OIDC, LDAP, GitHub)

### Advanced Features
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] ApplicationSets
  - [ ] Kustomize integration
  - [ ] Helm integration
  - [ ] Jsonnet
  - [ ] Progressive delivery (Canary, Blue-Green)

---

## 🐳 Container & Docker

Containerization technology for packaging applications.

### Docker Basics
- **Status**: ✅ In Progress
- **Resource**: [Docker Documentation](https://docs.docker.com/)
- **Topics to Cover**:
  - [x] Images and containers
  - [x] Dockerfile basics
  - [x] Building images
  - [ ] Docker compose
  - [ ] Docker registry

### Best Practices
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Image optimization
  - [ ] Security scanning
  - [ ] Multi-stage builds
  - [ ] Layering and caching

### Container Security
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Image scanning
  - [ ] Runtime security
  - [ ] Pod security policies
  - [ ] Network policies

---

## 🚀 CI/CD

Continuous Integration and Continuous Deployment pipelines.

### GitHub Actions
- **Status**: 📝 To Learn
- **Resource**: [GitHub Actions Documentation](https://docs.github.com/en/actions)
- **Topics to Cover**:
  - [ ] Workflow basics
  - [ ] Triggers (push, pull_request, schedule)
  - [ ] Jobs and steps
  - [ ] Actions marketplace
  - [ ] Secrets management

### GitLab CI/CD
- **Status**: 📝 To Learn
- **Resource**: [GitLab CI/CD Documentation](https://docs.gitlab.com/ee/ci/)
- **Topics to Cover**:
  - [ ] .gitlab-ci.yml
  - [ ] Pipelines
  - [ ] Jobs and stages
  - [ ] Runners

### Jenkins
- **Status**: 📝 To Learn
- **Resource**: [Jenkins Documentation](https://www.jenkins.io/doc/)
- **Topics to Cover**:
  - [ ] Installation and setup
  - [ ] Pipeline syntax
  - [ ] Plugins
  - [ ] Integration with K8s

### General CI/CD Concepts
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Build automation
  - [ ] Testing automation
  - [ ] Deployment automation
  - [ ] Artifact management
  - [ ] Rollback strategies

---

## 📊 Monitoring & Logging

Observability stack for monitoring applications and infrastructure.

### Prometheus
- **Status**: 📝 To Learn
- **Resource**: [Prometheus Documentation](https://prometheus.io/docs/)
- **Topics to Cover**:
  - [ ] Installation
  - [ ] Scrape configuration
  - [ ] Metrics and queries (PromQL)
  - [ ] Alerting rules
  - [ ] Service discovery

### Grafana
- **Status**: 📝 To Learn
- **Resource**: [Grafana Documentation](https://grafana.com/docs/)
- **Topics to Cover**:
  - [ ] Installation
  - [ ] Dashboard creation
  - [ ] Data sources
  - [ ] Alerting
  - [ ] Plugins

### Logging Stack (ELK / EFK)
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Elasticsearch
  - [ ] Fluentd / Logstash
  - [ ] Kibana
  - [ ] Log aggregation
  - [ ] Log parsing

### Loki
- **Status**: 📝 To Learn
- **Resource**: [Loki Documentation](https://grafana.com/docs/loki/latest/)
- **Topics to Cover**:
  - [ ] Installation
  - [ ] Log labels
  - [ ] LogQL
  - [ ] Integration with Grafana

### Observability Best Practices
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Metrics, Logs, Traces (Three Pillars)
  - [ ] Alerting strategies
  - [ ] SLO/SLI/SLA
  - [ ] Debugging with traces

---

## 🏗️ Infrastructure as Code

Infrastructure management through code.

### Terraform
- **Status**: 📝 To Learn
- **Resource**: [Terraform Documentation](https://www.terraform.io/docs)
- **Topics to Cover**:
  - [ ] Installation
  - [ ] HCL basics
  - [ ] Providers
  - [ ] Resources and data sources
  - [ ] State management
  - [ ] Modules
  - [ ] Workspaces

### Ansible
- **Status**: 📝 To Learn
- **Resource**: [Ansible Documentation](https://docs.ansible.com/)
- **Topics to Cover**:
  - [ ] Installation
  - [ ] Inventory
  - [ ] Playbooks
  - [ ] Roles
  - [ ] Variables and templating

### Kustomize
- **Status**: 📝 To Learn
- **Resource**: [Kustomize Documentation](https://kustomize.io/)
- **Topics to Cover**:
  - [ ] Overlays
  - [ ] Bases
  - [ ] Patching
  - [ ] ConfigMap/Secret generation

### Pulumi
- **Status**: 📝 To Learn
- **Resource**: [Pulumi Documentation](https://www.pulumi.com/docs/)
- **Topics to Cover**:
  - [ ] Installation
  - [ ] Programming languages support
  - [ ] Infrastructure definition
  - [ ] Deployment

---

## 🔐 Security

Security concepts and tools for cloud-native applications.

### Authentication & Authorization
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] RBAC (Role-Based Access Control)
  - [ ] OAuth 2.0
  - [ ] OpenID Connect (OIDC)
  - [ ] SAML
  - [ ] Kubernetes RBAC

### Secrets Management
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Kubernetes Secrets
  - [ ] HashiCorp Vault
  - [ ] External Secrets Operator
  - [ ] Secret rotation

### Network Security
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Network Policies
  - [ ] Service Mesh (Istio, Linkerd)
  - [ ] mTLS
  - [ ] Ingress security

### Image & Container Security
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Image scanning
  - [ ] Vulnerability scanning
  - [ ] Pod Security Standards
  - [ ] Admission controllers

---

## 🔄 Advanced Topics

Advanced and specialized topics for cloud-native development.

### Service Mesh
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Istio basics
  - [ ] Linkerd
  - [ ] Traffic management
  - [ ] Observability integration
  - [ ] Canary deployments

### Serverless
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Knative
  - [ ] AWS Lambda
  - [ ] Function concepts
  - [ ] Event-driven architecture

### Multi-Cloud
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Multi-cluster management
  - [ ] Cluster federation
  - [ ] Cross-cloud deployment

### GitOps Advanced
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] Progressive delivery
  - [ ] Canary releases
  - [ ] Blue-green deployments
  - [ ] Feature flags integration

### eBPF & Kernel Programming
- **Status**: 📝 To Learn
- **Topics to Cover**:
  - [ ] eBPF basics
  - [ ] Cilium
  - [ ] Performance monitoring
  - [ ] Security monitoring

---

## 💾 Project Resources

### Current Projects
- **Kind Cluster Learning** - Located in `k8s-learning/`
  - Basic K8s resource examples
  - Deployment, Service, ConfigMap, Secret
  - Comprehensive learning documentation

- **ArgoCD Installation** - Located in `argocd_install/`
  - ArgoCD setup and configuration

### Tools & Commands
- **kubectl Cheatsheet**: `k8s-learning/CHEATSHEET.md`
- **Kubernetes Guide**: `k8s-learning/README.md`
- **Deployment Scripts**: `k8s-learning/deploy.ps1` (PowerShell) / `deploy.sh` (Bash)

---

## 📝 How to Use This Document

### Status Legend
- ✅ **Completed** - Topic fully learned and understood
- ✅ **In Progress** - Currently learning
- 📝 **To Learn** - Planned for future learning
- ❌ **Blocked** - Need prerequisites or resources

### Adding New Topics
When learning a new technology, follow this template:

```markdown
### [Technology Name]
- **Status**: 📝 To Learn / ✅ In Progress
- **Resource**: [Link to documentation/course]
- **Description**: Brief description
- **Topics to Cover**:
  - [ ] Topic 1
  - [ ] Topic 2
  - [ ] Topic 3
```

### Updating Progress
- Check off completed items with `[x]`
- Change status as you progress
- Add dates for reference if helpful

---

## 🎯 Learning Goals (2026)

### Q3 2026
- [ ] Master Kubernetes core concepts
- [ ] Set up local Kind cluster
- [ ] Learn kubectl thoroughly
- [ ] Understand Services and Networking

### Q4 2026
- [ ] Install and configure ArgoCD
- [ ] Learn GitOps principles
- [ ] Set up CI/CD pipeline
- [ ] Basic monitoring with Prometheus/Grafana

### 2027 Goals
- [ ] Advanced K8s (StatefulSets, Operators)
- [ ] Service mesh (Istio/Linkerd)
- [ ] Terraform for infrastructure
- [ ] Production-ready deployments

---

## 🔗 Useful Links

### Official Documentation
- [Kubernetes Official Docs](https://kubernetes.io/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Helm Charts](https://helm.sh/)

### Learning Platforms
- [Kubernetes Academy (Linux Foundation)](https://www.linuxfoundation.org/)
- [Katacoda Interactive Scenarios](https://www.katacoda.com/)
- [Play with Kubernetes](https://labs.play-with-k8s.com/)
- [KodeKloud - DevOps Courses](https://kodekloud.com/)

### Community Resources
- [Kubernetes Slack Community](https://kubernetes.slack.com/)
- [CNCF Community](https://www.cncf.io/community/)
- [Stack Overflow - kubernetes tag](https://stackoverflow.com/questions/tagged/kubernetes)

### YouTube Channels
- [Kubernetes Official Channel](https://www.youtube.com/@kubernetesio)
- [TechWorld with Nana](https://www.youtube.com/@TechWorldwithNana)
- [That DevOps Guy](https://www.youtube.com/@thatdevopsguy)

---

## 📅 Last Updated

**Date**: 2026-07-13  
**Next Review**: 2026-07-20

---

## 📞 Notes & References

### Quick References
- kubectl quick commands: See `k8s-learning/CHEATSHEET.md`
- K8s resource structure: See `k8s-learning/README.md`

### Troubleshooting
- Common K8s issues: See `k8s-learning/README.md#debugging`
- Docker issues: See Docker Documentation link above

---

**Keep Learning! 🚀**

This is a living document. Update it regularly as you progress through your learning journey!
