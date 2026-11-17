import 'package:dev_path/models/roadmap_step_model.dart';

final List<RoadmapStepModel> devopsRoadmapSteps = [
  RoadmapStepModel(
    id: 1,
    title: 'Linux Administration & Shell Scripting',
    description:
        'Master Linux OS administration, file system hierarchies, permission management, and automation with Bash scripting.',
    duration: '2-3 weeks',
    phase: 'Phase 1: Foundation',
    level: 'Beginner',
    learningObjectives:
        'Navigate Linux CLI, manage users and process permissions, write automated shell scripts, and manage cron jobs.',
    subtopics: [
      'Linux Kernel architecture & POSIX file system structure',
      'Essential terminal commands (cd, ls, grep, awk, sed, find)',
      'User, group, file permissions (chmod, chown, umask)',
      'Process management (ps, top, htop, kill, systemctl, systemd)',
      'Package management (apt, yum, dnf, pacman)',
      'Bash scripting: variables, parameters, positional arguments',
      'Control structures: if-else, case, while, for loops in Bash',
      'Text processing with awk, sed, and regular expressions',
      'Standard I/O redirection, pipes (|), tee, and error streams (2>&1)',
      'Automating tasks with crontab & systemd timer units',
    ],
    exercises: [
      'Write a Bash script to monitor CPU and memory usage and send alerts when usage exceeds 80%.',
      'Create an automated backup script that archives specific directories and deletes archives older than 7 days.',
    ],
    resources: [
      'Linux Command Line Tutorial: https://ubuntu.com/tutorials/command-line-for-beginners',
      'Bash Scripting Guide: https://devdocs.io/bash/',
      'Linux Foundation Training: https://training.linuxfoundation.org',
    ],
  ),
  RoadmapStepModel(
    id: 2,
    title: 'Networking & Security Fundamentals',
    description:
        'Understand OSI model layers, TCP/IP networking protocols, DNS resolution, SSH tunneling, and firewall rules.',
    duration: '2 weeks',
    phase: 'Phase 1: Foundation',
    level: 'Beginner',
    learningObjectives:
        'Configure IP subnets, diagnose network latency with ping and traceroute, manage SSH keys, and configure UFW firewalls.',
    subtopics: [
      'OSI 7-layer model vs TCP/IP protocol suite',
      'IP addressing, IPv4 vs IPv6, CIDR notation & subnetting',
      'TCP handshake, UDP datagrams, port numbers & sockets',
      'DNS hierarchy: A, AAAA, CNAME, MX, TXT records & resolution path',
      'HTTP/1.1, HTTP/2, HTTPS, SSL/TLS handshake & certificates',
      'SSH key-based authentication, SSH agent forwarding & tunneling',
      'Network diagnostics with netstat, ss, dig, nslookup, curl, traceroute',
      'Firewall configuration with UFW, iptables & firewalld',
      'Reverse proxies & Load balancing concepts with NGINX',
      'Virtual Private Networks (VPNs) & NAT gateway mechanics',
    ],
    exercises: [
      'Set up an NGINX reverse proxy forwarding traffic to a local web application with custom SSL/TLS certificates.',
      'Configure a secure SSH bastion host restricting direct root access and requiring public key auth.',
    ],
    resources: [
      'Cloudflare Learning Center: https://www.cloudflare.com/learning/network-layer/what-is-the-network-layer/',
      'NGINX Official Documentation: https://nginx.org/en/docs/',
      'DigitalOcean Networking Guides: https://www.digitalocean.com/community/tutorials',
    ],
  ),
  RoadmapStepModel(
    id: 3,
    title: 'Containerization with Docker',
    description:
        'Build, containerize, and run multi-container microservices applications using Docker Engine and Docker Compose.',
    duration: '2-3 weeks',
    phase: 'Phase 2: Core Tooling',
    level: 'Intermediate',
    learningObjectives:
        'Write optimized Dockerfiles, manage image layers, configure bridge networks, create persistent volumes, and orchestration with Docker Compose.',
    subtopics: [
      'Containers vs Virtual Machines: Namespaces & cgroups mechanics',
      'Docker architecture: Client, Daemon, Registries, Images, Containers',
      'Writing multi-stage Dockerfiles for minimal production images',
      'Understanding image layer caching & instructions (.dockerignore, COPY, RUN, CMD, ENTRYPOINT)',
      'Managing storage: Anonymous volumes, Named volumes, Bind mounts',
      'Docker networking: Bridge, Host, Overlay networks & container DNS',
      'Multi-container environments with Docker Compose (docker-compose.yml)',
      'Docker CLI commands (docker run, exec, logs, ps, inspect, prune)',
      'Publishing images to Docker Hub & private container registries (ECR, GHCR)',
      'Container security: non-root users, vulnerability scanning with Trivy',
    ],
    exercises: [
      'Write a multi-stage Dockerfile for a Go/Node app reducing image size below 30MB.',
      'Create a docker-compose setup launching a web backend, PostgreSQL database, and Redis cache with healthchecks.',
    ],
    resources: [
      'Docker Docs & Guides: https://docs.docker.com/',
      'Docker Curriculum Tutorial: https://docker-curriculum.com/',
    ],
  ),
  RoadmapStepModel(
    id: 4,
    title: 'Container Orchestration with Kubernetes',
    description:
        'Orchestrate production container workloads at scale using Kubernetes (k8s) pods, deployments, services, and ingress.',
    duration: '3-4 weeks',
    phase: 'Phase 3: Production Scale',
    level: 'Intermediate to Advanced',
    learningObjectives:
        'Deploy resilient workloads on Kubernetes, manage ConfigMaps & Secrets, configure Ingress controllers, and manage Helm charts.',
    subtopics: [
      'Kubernetes Architecture: Control Plane (api-server, etcd, scheduler) vs Worker Nodes (kubelet, kube-proxy)',
      'Kubectl CLI & cluster management context',
      'Core Workload Objects: Pods, ReplicaSets, Deployments, StatefulSets, DaemonSets',
      'Service Networking: ClusterIP, NodePort, LoadBalancer & Headless Services',
      'Configuring Ingress Controllers (NGINX Ingress) & Cert-Manager',
      'Configuration management: ConfigMaps & Encrypted Secrets',
      'Storage Architecture: PersistentVolumes (PV), PersistentVolumeClaims (PVC) & StorageClasses',
      'Resource requests, limits, Horizontal Pod Autoscaler (HPA) & Cluster Autoscaler',
      'Health Probes: Liveness, Readiness, and Startup probes',
      'Packaging Kubernetes applications with Helm charts & Kustomize',
    ],
    exercises: [
      'Deploy a 3-replica web app deployment with zero-downtime rolling updates and liveness health probes on minikube.',
      'Package a full-stack microservice into a Helm Chart with environment-specific values.yaml overrides.',
    ],
    resources: [
      'Kubernetes Official Docs: https://kubernetes.io/docs/',
      'Kubernetes Interactive Tutorials: https://kubernetes.io/docs/tutorials/',
      'Helm Package Manager Docs: https://helm.sh/docs/',
    ],
  ),
  RoadmapStepModel(
    id: 5,
    title: 'Infrastructure as Code (IaC) with Terraform',
    description:
        'Automate cloud infrastructure provisioning predictably using HashiCorp Terraform modules, states, and providers.',
    duration: '2-3 weeks',
    phase: 'Phase 3: Production Scale',
    level: 'Intermediate',
    learningObjectives:
        'Write HCL (HashiCorp Configuration Language), manage remote state backends with locking, modularize Terraform code, and execute plan/apply workflows.',
    subtopics: [
      'Declarative vs Imperative infrastructure provisioning principles',
      'Terraform Architecture: HCL Syntax, Providers, Resources, Data sources',
      'Managing State: terraform.tfstate, Remote S3/GCS backends, DynamoDB locking',
      'Terraform execution lifecycle: init, plan, apply, destroy, refresh',
      'Variables, Local values, Outputs, & Variable validation rules',
      'Terraform Modules: Creating reusable custom modules & Terraform Registry',
      'Resource dependencies, count, for_each, & dynamic blocks',
      'State manipulation: terraform import, state mv, state rm, targeted apply',
      'Automating IaC checks with tflint, tfsec, & Checkov',
      'Terraform Cloud & Atlantis for team collaborative gitops workflows',
    ],
    exercises: [
      'Provision a secure AWS VPC with public/private subnets, Internet Gateway, and NAT Gateway using Terraform.',
      'Create a reusable Terraform module for provisioning an S3 bucket with versioning and server-side encryption enabled.',
    ],
    resources: [
      'Terraform Official Docs: https://developer.hashicorp.com/terraform/docs',
      'Terraform AWS Provider Registry: https://registry.terraform.io/providers/hashicorp/aws/latest/docs',
    ],
  ),
  RoadmapStepModel(
    id: 6,
    title: 'Continuous Integration & Delivery (CI/CD)',
    description:
        'Design automated integration & deployment pipelines using GitHub Actions, GitLab CI, and ArgoCD for GitOps.',
    duration: '2-3 weeks',
    phase: 'Phase 4: Automation',
    level: 'Intermediate',
    learningObjectives:
        'Automate testing, linting, Docker image building, and production deployment pipelines on code pushes.',
    subtopics: [
      'CI/CD Pipeline Architecture: Triggers, Jobs, Steps, Runners, Artifacts',
      'GitHub Actions syntax: workflows, events (push, pull_request, workflow_dispatch)',
      'Managing Secrets, Environment Variables, & OIDC Authentication',
      'Caching dependencies & storing build artifacts',
      'Matrix builds for testing multiple OS & language versions',
      'GitLab CI/CD (.gitlab-ci.yml): stages, runners, environment deployment',
      'Deployment strategies: Rolling, Blue/Green, Canary releases',
      'GitOps Principles: Declaring state in Git & automated synchronization',
      'Deploying with ArgoCD & Flux on Kubernetes clusters',
      'Automated release management & semantic versioning (SemVer)',
    ],
    exercises: [
      'Build a GitHub Actions workflow that lints code, runs unit tests, builds a Docker image, and pushes it to GHCR on pull requests.',
      'Set up ArgoCD on a Kubernetes cluster to automatically sync deployments when git release tags update.',
    ],
    resources: [
      'GitHub Actions Documentation: https://docs.github.com/en/actions',
      'ArgoCD GitOps Guide: https://argo-cd.readthedocs.io/en/stable/',
    ],
  ),
  RoadmapStepModel(
    id: 7,
    title: 'Cloud Computing & AWS Architecture',
    description:
        'Architect resilient, cost-optimized, secure cloud applications on Amazon Web Services (AWS).',
    duration: '3-4 weeks',
    phase: 'Phase 4: Automation',
    level: 'Intermediate to Advanced',
    learningObjectives:
        'Design VPC network topologies, compute workloads with EC2 and ECS/EKS, manage IAM policies, and configure CloudWatch alerts.',
    subtopics: [
      'AWS Well-Architected Framework: Security, Reliability, Performance, Cost, Operational Excellence',
      'IAM (Identity and Access Management): Users, Groups, Roles, Policies, MFA',
      'VPC Topologies: CIDR, Subnets, Route Tables, IGW, NAT Gateways, VPC Peering',
      'Compute Services: EC2 instances, AMI creation, Auto Scaling Groups (ASG), Lambda serverless',
      'Storage Services: S3 bucket policies/lifecycle, EBS volumes, EFS network storage',
      'Database Services: Amazon RDS (PostgreSQL/MySQL), DynamoDB, ElastiCache (Redis)',
      'Networking & Content Delivery: CloudFront CDN, Route 53 DNS, Application Load Balancer (ALB)',
      'AWS Container Services: ECS (Elastic Container Service) with AWS Fargate & EKS',
      'Monitoring & Security: CloudWatch Metrics/Alarms, CloudTrail audit logs, AWS WAF',
      'Cost Management: Cost Explorer, AWS Budgets, Tagging strategies',
    ],
    exercises: [
      'Deploy a web application behind an AWS Application Load Balancer across two Availability Zones with Auto Scaling.',
      'Configure an AWS Lambda function triggered by S3 file uploads to process images asynchronously.',
    ],
    resources: [
      'AWS Documentation: https://docs.aws.amazon.com/',
      'AWS Skill Builder: https://explore.skillbuilder.aws/',
      'AWS Well-Architected Framework: https://aws.amazon.com/architecture/well-architected/',
    ],
  ),
  RoadmapStepModel(
    id: 8,
    title: 'Monitoring, Logging & Observability',
    description:
        'Implement full observability using Prometheus, Grafana, ELK/EFK stack, and distributed tracing.',
    duration: '2-3 weeks',
    phase: 'Phase 5: Observability & Security',
    level: 'Intermediate to Advanced',
    learningObjectives:
        'Instrument applications for metrics, configure Prometheus scraping, build Grafana dashboards, and analyze logs with ELK stack.',
    subtopics: [
      'The 3 Pillars of Observability: Metrics, Logs, Traces',
      'Prometheus Architecture: Time-series database, Pull model, Exporters, PromQL queries',
      'Configuring Prometheus Alertmanager for Slack, PagerDuty, email alerts',
      'Building interactive Grafana dashboards & visualization widgets',
      'Log Aggregation: ELK Stack (Elasticsearch, Logstash, Kibana) & Loki / Fluentbit',
      'Log parsing, structured JSON logs, log retention policies',
      'Distributed Tracing with OpenTelemetry, Jaeger, & AWS X-Ray',
      'Service Level Indicators (SLI), Service Level Objectives (SLO), Service Level Agreements (SLA)',
      'Synthetic monitoring, uptime checks, and synthetic user journeys',
      'Chaos engineering principles & fault injection with LitmusChaos',
    ],
    exercises: [
      'Set up Prometheus monitoring for a Node/Python service using node_exporter and build a custom Grafana CPU/Memory dashboard.',
      'Configure Loki and Promtail in a Docker Compose environment to collect and query application logs.',
    ],
    resources: [
      'Prometheus Docs: https://prometheus.io/docs/introduction/overview/',
      'Grafana Official Tutorials: https://grafana.com/tutorials/',
      'OpenTelemetry Docs: https://opentelemetry.io/docs/',
    ],
  ),
  RoadmapStepModel(
    id: 9,
    title: 'Configuration Management with Ansible',
    description:
        'Automate server provisioning, OS patching, and application deployments idempotently using Ansible playbooks.',
    duration: '2 weeks',
    phase: 'Phase 5: Observability & Security',
    level: 'Intermediate',
    learningObjectives:
        'Write YAML playbooks, create custom Ansible roles, manage inventory files, and encrypt secrets with Ansible Vault.',
    subtopics: [
      'Agentless architecture vs Agent-based configuration management',
      'Ansible Inventory files (static ini/yaml & dynamic cloud inventory)',
      'Ansible Modules: apt, service, copy, template, user, git, command',
      'Writing Ansible Playbooks: tasks, handlers, variables, facts',
      'Idempotency principles in configuration management',
      'Jinja2 templating for dynamic config file generation',
      'Organizing code with Ansible Roles & Ansible Galaxy',
      'Encrypting sensitive data with Ansible Vault (ansible-vault create/encrypt)',
      'Ansible execution strategies, serial deployment, & error handling',
      'Ansible Automation Platform / AWX for enterprise execution',
    ],
    exercises: [
      'Write an Ansible playbook that installs NGINX, configures custom site files via Jinja2 template, and starts the service idempotently.',
      'Create an Ansible role for hardening Linux OS security settings (disabling root login, setting up firewall rules).',
    ],
    resources: [
      'Ansible Official Documentation: https://docs.ansible.com/ansible/latest/index.html',
      'Ansible Galaxy Repository: https://galaxy.ansible.com/',
    ],
  ),
  RoadmapStepModel(
    id: 10,
    title: 'DevSecOps & Site Reliability Engineering (SRE)',
    description:
        'Integrate security into CI/CD pipelines, manage incident response workflows, and apply SRE principles to high-scale production systems.',
    duration: '3 weeks',
    phase: 'Phase 5: Observability & Security',
    level: 'Advanced',
    learningObjectives:
        'Embed SAST/DAST/SCA vulnerability scans into pipelines, run incident post-mortems, and establish Error Budgets.',
    subtopics: [
      'DevSecOps Principles: Shifting Security Left in SDLC',
      'Static Application Security Testing (SAST) with SonarQube & Semgrep',
      'Dynamic Application Security Testing (DAST) with OWASP ZAP',
      'Software Composition Analysis (SCA) & Container Scanning (Trivy, Snyk)',
      'Secret scanning in Git repositories (GitGuardian, gitleaks)',
      'Site Reliability Engineering (SRE) core principles & Error Budgets',
      'Incident management lifecycle: On-call rotation, PagerDuty, escalation policies',
      'Blameless Post-Mortems & Root Cause Analysis (RCA) techniques',
      'Disaster Recovery (DR) strategies: RTO (Recovery Time Objective) vs RPO (Recovery Point Objective)',
      'Zero Trust Network Architecture & Identity-First Cloud Security',
    ],
    exercises: [
      'Configure a GitHub Actions pipeline that fails builds if Trivy container vulnerability scan detects Critical vulnerabilities.',
      'Draft a blameless post-mortem document for a simulated database failover outage.',
    ],
    resources: [
      'Google SRE Books (Free Online): https://sre.google/sre-book/table-of-contents/',
      'OWASP DevSecOps Guideline: https://owasp.org/www-project-devsecops-guideline/',
    ],
  ),
];
