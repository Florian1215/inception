# Inception

A complete Docker-based infrastructure project featuring Nginx, WordPress, and MariaDB. This project demonstrates containerization, networking, volume management, and SSL/TLS certificate generation for a production-ready web stack.

## Overview

**Inception** is a Docker Compose project that sets up a complete web infrastructure with:

- **Nginx**: High-performance reverse proxy and web server with SSL/TLS support
- **WordPress**: Popular content management system running on PHP-FPM
- **MariaDB**: Reliable open-source relational database
- **Custom Docker Images**: Built from scratch with minimal, secure configurations
- **SSL/TLS Certificates**: Automatically generated for secure HTTPS connections
- **Persistent Volumes**: Data persistence for WordPress files and database

This project is ideal for:
- Learning Docker and containerization
- Setting up a local WordPress development environment
- Understanding multi-container orchestration with Docker Compose
- Implementing SSL/TLS certificates in Docker

## Project Structure

```
inception/
├── Makefile                           # Build and management rules
├── README.md                          # This file
├── .gitignore                         # Git ignore rules
└── srcs/
    ├── docker-compose.yml             # Docker Compose configuration
    ├── .env                           # Environment variables
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile             # Nginx container image
        │   └── conf/
        │       └── nginx.conf          # Nginx configuration
        ├── wordpress/
        │   ├── Dockerfile             # WordPress container image
        │   └── conf/
        │       └── www.conf            # PHP-FPM configuration
        └── mariadb/
            ├── Dockerfile             # MariaDB container image
            ├── conf/
            │   └── my.cnf              # MariaDB configuration
            └── tools/
                └── create_database.sh  # Database initialization script
```

## Prerequisites

Before you begin, ensure you have the following installed:

- **Docker**: Version 20.10+
  ```bash
  docker --version
  ```
- **Docker Compose**: Version 2.0+
  ```bash
  docker-compose --version
  ```
- **Make**: Standard build tool
  ```bash
  make --version
  ```
- **OpenSSL**: For generating SSL/TLS certificates
  ```bash
  openssl version
  ```

**Supported Operating Systems:**
- Linux (recommended)
- macOS
- Windows with WSL2 (Windows Subsystem for Linux 2)

## Installation & Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/fguirama/inception.git
cd inception
```

### Step 2: Configure Environment Variables

The project uses environment variables stored in `srcs/.env`. Create or update this file with your configuration:

```bash
# Domain configuration
DOMAIN=login.42.fr

# WordPress volume mount path
VOLUME_WP=/home/login/data/wordpress

# Database volume mount path
VOLUME_DB=/home/login/data/mariadb

# WordPress configuration
WP_TITLE=My WordPress Site
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=secure_password_123
WP_ADMIN_EMAIL=admin@example.com
WP_URL=https://login.42.fr

# Database configuration
DB_NAME=wordpress
DB_USER=wordpress_user
DB_PASSWORD=db_password_123
DB_ROOT_PASSWORD=root_password_123
DB_HOST=mariadb
```

### Step 3: Build and Start the Project

```bash
# Build and start all containers
make all

# Or separately:
make build    # Build Docker images
make up       # Start containers
```

The project will:
1. Create necessary directories for data persistence
2. Generate SSL/TLS certificates in `./.SECRET/`
3. Build custom Docker images
4. Start all services


## Usage

### Accessing the Services

- **WordPress**: https://login.42.fr
- **WordPress Admin Panel**: https://login.42.fr/wp-admin
- **Nginx**: Proxy server (port 443)
- **MariaDB**: Database server (exposed internally, port 3306)

### Common Operations

#### Start Services
```bash
make up
```

#### Stop Services
```bash
make clean
```

#### Rebuild from Scratch
```bash
make re
```

#### View Logs
```bash
docker-compose -f srcs/docker-compose.yml logs -f [service_name]

# Examples:
docker-compose -f srcs/docker-compose.yml logs -f nginx
docker-compose -f srcs/docker-compose.yml logs -f wordpress
docker-compose -f srcs/docker-compose.yml logs -f mariadb
```

#### Execute Commands in Containers
```bash
# WordPress container
docker exec -it wordpress bash

# MariaDB container (MySQL CLI)
docker exec -it mariadb mysql -u root -p

# Nginx container
docker exec -it nginx bash
```

#### Clean Up Everything
```bash
make fclean          # Remove all containers, volumes, networks, and data
make prune           # Remove unused Docker resources
```

## Architecture

### Service Dependency Graph

```
nginx (port 443)
  └─> wordpress (port 9000)
      └─> mariadb (port 3306)
```

### Network

All services communicate through a custom Docker bridge network named `inception`. This provides:
- Service-to-service DNS resolution by container name
- Isolated network traffic
- No exposure of internal services to the host (except Nginx on port 443)

### Volumes

| Volume | Mount Path | Purpose |
|--------|-----------|---------|
| `wordpress` | `$VOLUME_WP` | WordPress installation files and uploads |
| `mariadb` | `$VOLUME_DB` | MariaDB database files |

### Secrets

SSL/TLS certificates are managed as Docker secrets:
- `ssl_key`: Private key from `./.SECRET/ssl_key`
- `ssl_crt`: Certificate from `./.SECRET/ssl_crt`

## Makefile Commands

| Command | Description |
|---------|-------------|
| `make all` | Build and start all containers (default) |
| `make up` | Start containers without rebuilding |
| `make build` | Build Docker images only |
| `make clean` | Stop and remove containers |
| `make fclean` | Remove everything including volumes and data |
| `make prune` | Remove unused Docker resources |
| `make re` | Full rebuild (fclean + all) |

### Makefile Variables

The Makefile uses variables that can be customized:

```makefile
NAME=inception              # Project name
LOGIN=fguirama              # User login
DOMAIN=fguirama.42.fr       # Domain name
DATA_DIR=/home/fguirama/data  # Base data directory
```


## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [WordPress Documentation](https://wordpress.org/support/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
