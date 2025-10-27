#!/bin/bash
# DevOps Simulator Deployment Script
# Merged Production + Development
# Production Version: 1.0.0
# Development Version: 2.0.0-beta

set -e

echo "====================================="
echo "DevOps Simulator Deployment"
echo "====================================="

# Choose environment: "production" or "development"
DEPLOY_ENV="${DEPLOY_ENV:-development}"  # Default to development if not set

if [ "$DEPLOY_ENV" == "production" ]; then
    # Production configuration
    APP_PORT=8080
    DEPLOY_REGION="us-east-1"
    echo "Environment: $DEPLOY_ENV"
    echo "Region: $DEPLOY_REGION"
    echo "Port: $APP_PORT"

    # Pre-deployment checks
    echo "Running pre-deployment checks..."
    if [ ! -f "config/app-config.yaml" ]; then
        echo "Error: Configuration file not found!"
        exit 1
    fi

    # Deploy application (production)
    echo "Starting deployment..."
    echo "Pulling latest Docker images..."
    # docker pull devops-simulator:latest

    echo "Rolling update strategy initiated..."
    # kubectl rolling-update devops-simulator

    echo "Deployment completed successfully!"
    echo "Application available at: https://app.example.com"

else
    # Development configuration
    APP_PORT=3000
    DEPLOY_MODE="docker-compose"
    ENABLE_DEBUG=true
    echo "Environment: $DEPLOY_ENV"
    echo "Mode: $DEPLOY_MODE"
    echo "Port: $APP_PORT"
    echo "Debug: $ENABLE_DEBUG"

    # Pre-deployment checks
    echo "Running pre-deployment checks..."
    if [ ! -f "config/app-config.yaml" ]; then
        echo "Error: Configuration file not found!"
        exit 1
    fi

    # Install dependencies
    echo "Installing dependencies..."
    npm install

    # Run tests
    echo "Running tests..."
    npm test

    # Deploy application (development)
    echo "Starting deployment..."
    echo "Using Docker Compose..."
    docker-compose up -d

    # Wait for application to start
    echo "Waiting for application to be ready..."
    sleep 5

    # Health check
    echo "Performing health check..."
    curl -f http://localhost:$APP_PORT/health || exit 1

    echo "Deployment completed successfully!"
    echo "Application available at: http://localhost:$APP_PORT"
    echo "Hot reload enabled - code changes will auto-refresh"
fi
