# Kubernetes GitOps Demo

This repository showcases a practical implementation of GitOps principles for managing cloud-native infrastructure and applications. The project uses Terraform for infrastructure provisioning, Kubernetes for orchestration, and integrates monitoring and automation tools to ensure a robust and scalable deployment workflow.

---

## Features

- **Infrastructure as Code (IaC):** Automate cloud infrastructure with Terraform.
- **Kubernetes Orchestration:** Deploy containerized applications with Kubernetes manifests.
- **GitOps Workflow:** Synchronize Kubernetes clusters with Git repository changes via ArgoCD.
- **Monitoring:** Use Prometheus and Grafana for observability.
- **Notifications:** Slack integration for deployment and alert notifications.

---

## Repository Structure

```plaintext
/terraform                # Terraform configurations for cloud resources
/kubernetes               # Kubernetes manifests for application deployment
/monitoring               # Prometheus and Grafana setup
/slack-integration        # Slack webhook configurations
/docs                     # Project-related documentation
.gitignore                # Ignore files for version control
README.md                 # Project overview and instructions
```

---

## Prerequisites

- Terraform v1.5+
- kubectl configured for your Kubernetes cluster
- AWS CLI with credentials
- Helm for managing Kubernetes applications

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-repo/kubernetes-gitops-demo.git
cd kubernetes-gitops-demo
```

### 2. Provision Infrastructure with Terraform

1. Navigate to the Terraform directory:

   ```bash
   cd terraform
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Plan and apply changes:

   ```bash
   terraform plan -out=tfplan.out
   terraform apply "tfplan.out"
   ```

### 3. Deploy Applications

1. Navigate to the Kubernetes directory:

   ```bash
   cd ../kubernetes
   ```

2. Apply the manifests:

   ```bash
   kubectl apply -f .
   ```

### 4. Set Up Monitoring

1. Navigate to the Monitoring directory:

   ```bash
   cd ../monitoring
   ```

2. Apply monitoring resources:

   ```bash
   kubectl apply -f .
   ```

3. Access Grafana and configure Prometheus as a data source.

---

## Automation with GitOps

Deployments are automated via ArgoCD:

1. Install ArgoCD:

   ```bash
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```

2. Configure ArgoCD to sync with the repository.

---

## Monitoring

- **Prometheus:** Gathers metrics from Kubernetes and applications.
- **Grafana:** Displays customizable dashboards for visualizing metrics.
- **Alerts:** Configure thresholds for critical metrics like CPU or memory usage.

---

## Notifications

Slack integration provides real-time updates:

1. Add your Slack webhook to the `slack-integration/` directory.
2. Configure deployment and monitoring alerts to trigger notifications.

---

## Known Issues

1. **S3 Bucket Name Conflict**:

   - Problem: Terraform may fail with a `BucketAlreadyExists` error if the S3 bucket name is not unique.
   - Solution: Use a globally unique name when specifying the bucket in `main.tf`.

2. **IAM Role Permission Errors**:

   - Problem: Insufficient permissions for Terraform to create and manage AWS resources (e.g., EKS, S3, DynamoDB).
   - Solution: Ensure your AWS credentials have admin-level permissions or the necessary policies for EKS, S3, and DynamoDB.

3. **ArgoCD Sync Issues**:
   - Problem: ArgoCD fails to sync due to improperly formatted Kubernetes manifests.
   - Solution: Validate manifests with `kubectl apply -f <file>` locally before committing.

---

## Contributions

Contributions are welcome. Fork this repository, make updates, and submit a pull request.

---

## License

Licensed under the MIT License. See `LICENSE` for details.

---

### What Was Removed and Why

1. **Detailed CI/CD Pipeline YAML**:

   - **Why Removed:** The GitOps workflow explanation and ArgoCD steps already provide sufficient clarity. Including a full YAML adds unnecessary bulk unless this pipeline is a core deliverable.

2. **Simplified Version Section**:

   - **Why Removed:** This project assumes users are committed to a full GitOps implementation. Including a "simplified version" might confuse the scope or purpose.

3. **Best Practices Section**:
   - **Why Removed:** The instructions and repository structure inherently reflect best practices, so the section is redundant.

### What Was Added and Why

1. **Slack Integration Details**:

   - **Why Added:** Explicit steps to configure Slack are critical for the notifications feature.

2. **Monitoring Section**:

   - **Why Added:** Clearly separating monitoring from automation ensures users know how to configure and validate their observability setup.

3. **Concise Workflow Steps**:
   - **Why Added:** Streamlined steps focus on delivering actionable guidance without clutter.
