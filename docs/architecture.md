# System Architecture

## Overview
DevOps Simulator follows a microservices architecture designed for high availability and scalability. This document includes both production and development architecture details.

## Components

### 1. Application Server
- **Technology**: Node.js + Express
- **Port**: 8080 (production), 3000 (development with hot reload)
- **Scaling**: Horizontal auto-scaling enabled (production), Manual single instance (development)
- **Debug**: Chrome DevTools debugger on port 9229 (development)

### 2. Database Layer
- **Database**: PostgreSQL 14
- **Configuration**: Master-slave replication (production), Single instance (development)
- **Backup**: Daily automated backups (production), Manual backups (development)
- **Seeding**: Auto-seed with test data on startup (development)

### 3. Monitoring System
- **Tool**: Prometheus + Grafana (production), Basic console logging + Prometheus optional (development)
- **Metrics**: CPU, Memory, Disk, Network, Build time (development)
- **Alerts**: Email notifications (production), Console warnings (development)
- **Dashboard**: Web dashboard (development)

### 4. Container Orchestration (Development Only)
- **Tool**: Docker Compose
- **Services**: App, Database, Redis cache
- **Volume Mounts**: Code directory for hot reload

### 5. Authentication System (Beta, Development Only)
- **Method**: OAuth2 + JWT
- **Providers**: Google, GitHub (testing)
- **Sessions**: Redis-based session storage

## Deployment Strategy
- **Production**: Rolling updates, zero-downtime, automated rollback on failure
- **Development**: Docker Compose hot reload, rollback via Git checkout, zero-downtime not applicable

## Development Workflow
1. Make code changes
2. Auto-reload triggers rebuild
3. Run unit tests
4. Check console logs
5. Commit when ready

## Security
- Production: SSL/TLS encryption, database connection encryption, regular security audits
- Development: SSL/TLS disabled, database credentials in plain text, CORS enabled for all origins, debug endpoints exposed

## Experimental Features (Development Only)
⚠️ **Warning**: The following features are experimental:
- Multi-cloud deployment
- AI-powered log analysis
- Automatic rollback on anomaly detection
