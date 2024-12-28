# Kubernetes GitOps Demo

An end-to-end project showcasing Kubernetes application deployment using GitOps, Terraform, and Slack integrations. This project demonstrates how to automate infrastructure provisioning, application deployments, and monitoring setup.

## Features

- **Terraform**: Infrastructure as Code (IaC) for creating scalable cloud resources.
- **Kubernetes**: Container orchestration for deploying and managing applications.
- **GitOps**: ArgoCD integration for managing Kubernetes manifests via Git.
- **Slack Integration**: Real-time deployment notifications using Slack.
- **Monitoring**: Prometheus and Grafana setup for metrics collection and visualization.

## Folder Structure

- **terraform/**: Infrastructure provisioning using Terraform.
- **kubernetes/**: Kubernetes manifests and configurations.
- **gitops/**: GitOps workflows and ArgoCD configurations.
- **monitoring/**: Monitoring setup with Prometheus and Grafana.
- **slack-integration/**: Scripts and configurations for Slack notifications.

## Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/patmejia/kubernetes-gitops-demo.git
   cd kubernetes-gitops-demo
   ```

2. Follow the instructions in each folder's README.md to set up:

   - Terraform infrastructure
   - Kubernetes cluster and deployments
   - GitOps workflows with ArgoCD
   - Monitoring stack
   - Slack notifications

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
