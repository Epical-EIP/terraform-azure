# Epical Integration Platform (EIP) module for Terraform

A comprehensive Terraform module for deploying the Epical Integration Platform on Azure. This module provides a complete infrastructure setup with CAF-compliant naming conventions and enterprise-grade features.

## Features

### Core Azure Resources

- **Resource Groups** - Logical containers for organizing Azure resources
- **Virtual Networks** - Network isolation and segmentation with subnet support
- **NAT Gateway** - Outbound internet connectivity for private subnets
- **Public IP Addresses** - External IP addressing

### Integration & Messaging

- **Event Grid Domain** - Event-driven architecture for pub/sub messaging with custom topics
- **Service Bus** - Enterprise messaging with queues and topics for reliable asynchronous communication

### Compute & Application Hosting

- **Function Apps** - Serverless compute with:
  - Managed identities for secure authentication
  - Key Vault integration for secrets management
  - Application Insights integration
  - Virtual network integration support
- **App Service Plans** - Hosting plans for Azure App Services
- **API Management (APIM)** - API gateway and management layer

### Data Storage

- **Storage Accounts** - Blob, file, queue, and table storage with:
  - Private endpoints support
  - Diagnostic settings for monitoring
  - RBAC integration
  - Network rules and firewall configuration
- **Cosmos DB** - Globally distributed NoSQL database with virtual network integration

### Security & Secrets Management

- **Key Vault** - Secure storage for secrets, keys, and certificates
- **RBAC (Role-Based Access Control)** - Fine-grained access management across all resources
- **Managed Identities** - Secure authentication between Azure services without credentials

### Monitoring & Observability

- **Log Analytics Workspace** - Centralized logging and analytics
- **Diagnostic Settings** - Resource-level monitoring integration across all supported services

## Key Capabilities

- **CAF-Compliant Naming** - Uses Azure Naming module for consistent, compliant resource naming
- **Multi-Environment Support** - Deploy to dev, test, or production environments
- **Customer-Specific Configuration** - Customizable resource naming with customer abbreviations
- **Telemetry Support** - Built-in telemetry capabilities for monitoring and diagnostics
- **Comprehensive Tagging** - Default tags applied across all resources for better organization
- **Feature Flags** - Conditional deployment of resources based on enabled features
- **Modular Design** - Clean separation of concerns with dedicated configuration files per resource type
