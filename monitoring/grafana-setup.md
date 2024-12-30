# Grafana Setup and Configuration

## Overview

This document details the steps to configure Grafana with Prometheus for monitoring in the Kubernetes GitOps demo project.

---

## Prerequisites

- Kubernetes cluster with Prometheus installed.
- AWS EBS CSI driver installed and properly configured.
- IAM policies attached to the worker node role:
  - AmazonEKSWorkerNodePolicy
  - AmazonEC2ContainerRegistryReadOnly
  - AmazonEBSCSIDriverPolicy

---

## Steps to Set Up Grafana

### 1. Install Grafana

Deploy Grafana in your cluster:

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana --namespace monitoring --create-namespace
```

### 2. Get Grafana Admin Password

Retrieve the default admin password:

```bash
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

### 3. Port-Forward Grafana

Access Grafana locally by port-forwarding:

```bash
kubectl port-forward --namespace monitoring svc/grafana 3000:80
```

Open `http://localhost:3000` in your browser.

---

## Connecting Grafana to Prometheus

### 1. Add Prometheus as a Data Source

1. Log in to Grafana (`admin` username and password from above).
2. Navigate to **Configuration > Data Sources**.
3. Add a new data source:
   - **Name**: `Prometheus`
   - **Type**: `Prometheus`
   - **URL**: `http://prometheus-server.default.svc.cluster.local`

### 2. Test the Connection

Click **Save & Test**. Ensure the "Successfully queried the Prometheus API" message appears.

---

## Creating Dashboards

1. Navigate to **Dashboards > New Dashboard**.
2. Use the query editor to build panels with Prometheus queries (e.g., `up` for active targets).
3. Save and organize panels as needed.

---

## Troubleshooting

1. PVC Issues:

   - Check PersistentVolumeClaims (PVCs):

     ```bash
     kubectl get pvc -n default
     ```

   - Verify storage class, node labels, and IAM permissions for EBS CSI.

2. Logs:

   - Inspect Grafana or Prometheus logs for errors:

     ```bash
     kubectl logs -n monitoring -l app.kubernetes.io/name=grafana
     kubectl logs -n default -l app.kubernetes.io/name=prometheus
     ```

---

## References

- [Grafana Documentation](https://grafana.com/docs/)
- [Prometheus Documentation](https://prometheus.io/docs/)
