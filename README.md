# *This project has been created as part of the 42 curriculum by vpogorel.*

# Inception

## Description

### Project Overview

**Inception** is a system administration project from the 42 curriculum that introduces containerization using Docker. The objective is to design and deploy a complete web infrastructure composed of multiple isolated services, each running inside its own Docker container and communicating through a dedicated Docker network.

The project emphasizes infrastructure as code, service isolation, security, persistence, and reproducibility. Every service is built from custom Dockerfiles rather than pre-built images (except where explicitly allowed), and the entire infrastructure is orchestrated using Docker Compose.

A typical deployment includes:

* **NGINX** as a reverse proxy with TLS support.
* **WordPress** running with PHP-FPM.
* **MariaDB** as the database server.
* Persistent Docker volumes for application and database data.
* A private Docker network for secure communication between containers.
* Secrets management for sensitive credentials.

### Project Goals

The primary goals of this project are to:

* Learn how Docker containers work.
* Understand multi-container architectures.
* Deploy a secure web application stack.
* Manage persistent storage.
* Configure networking between isolated services.
* Apply infrastructure automation through Docker Compose.
* Gain experience with Linux system administration concepts.

### Docker Usage

Docker is used to package every service into its own isolated container. Each service contains only the software required for its role, making deployments reproducible across different machines.

This project uses:

* Custom Dockerfiles
* Docker Compose
* Named Docker volumes
* User-defined bridge networks
* Docker secrets (or equivalent secure credential management)

Because every service is isolated, containers can be rebuilt independently without affecting the rest of the infrastructure.

### Sources Included in the Project

The repository typically contains:

```text
.
├── Makefile
├── README.md
└── srcs
    ├── docker-compose.yml
    ├── .env
    └── requirements
        ├── nginx
        │   ├── Dockerfile
        │   └── conf/
        ├── mariadb
        │   ├── Dockerfile
        │   └── tools/
        └── wordpress
            ├── Dockerfile
            └── tools/
```

The exact structure may vary depending on the implementation.

### Main Design Choices

The infrastructure was designed around the following principles:

* One process per container.
* Custom Docker images built from Dockerfiles.
* Containers communicate only through an internal Docker network.
* Persistent application data stored in Docker volumes.
* Reverse proxy handled by NGINX.
* Database isolated from external access.
* TLS encryption enabled for secure HTTP communication.
* Credentials separated from application configuration.

---

## Design Comparisons

### Virtual Machines vs Docker

| Virtual Machines                       | Docker                                   |
| -------------------------------------- | ---------------------------------------- |
| Virtualize an entire operating system. | Virtualize only applications.            |
| Require a hypervisor.                  | Share the host kernel.                   |
| Higher resource usage.                 | Lightweight and efficient.               |
| Slower startup.                        | Containers start almost instantly.       |
| Better for complete OS isolation.      | Better for microservices and deployment. |

Docker was chosen because it provides faster deployment, lower resource consumption, and simplifies application distribution.

---

### Secrets vs Environment Variables

| Docker Secrets                      | Environment Variables                        |
| ----------------------------------- | -------------------------------------------- |
| Designed for sensitive information. | Intended mainly for configuration.           |
| Not exposed in image layers.        | Can be visible through container inspection. |
| More secure.                        | Easier to accidentally leak.                 |
| Better for production.              | Convenient for development.                  |

Sensitive information such as passwords should be stored as secrets whenever possible, while non-sensitive configuration values can safely remain as environment variables.

---

### Docker Network vs Host Network

| Docker Bridge Network                                       | Host Network                                    |
| ----------------------------------------------------------- | ----------------------------------------------- |
| Containers communicate through an isolated virtual network. | Containers share the host network stack.        |
| Better security.                                            | Less isolation.                                 |
| Supports service discovery by container name.               | Uses host ports directly.                       |
| Default choice for Docker Compose.                          | Mainly useful for specialized networking needs. |

A dedicated bridge network improves isolation while allowing services like WordPress and MariaDB to communicate securely.

---

### Docker Volumes vs Bind Mounts

| Docker Volumes                          | Bind Mounts                         |
| --------------------------------------- | ----------------------------------- |
| Managed entirely by Docker.             | Direct mapping to host directories. |
| Portable across systems.                | Depends on host filesystem layout.  |
| Better for persistent application data. | Useful during development.          |
| More secure and easier to back up.      | Easy to inspect and edit manually.  |

Named Docker volumes are preferred because they provide persistence while remaining independent of the host filesystem.

---

# Instructions

## Requirements

* Docker
* Docker Compose
* GNU Make

## Build the project

```bash
make
```

or

```bash
docker compose up --build
```

## Start the infrastructure

```bash
make up
```

or

```bash
docker compose up -d
```

## Stop the infrastructure

```bash
make down
```

or

```bash
docker compose down
```

## Remove containers, images, and volumes

```bash
make fclean
```

or

```bash
docker compose down --volumes --rmi all
```

---

# Project Architecture

```text
                Internet
                    │
                 HTTPS (443)
                    │
               ┌──────────┐
               │  NGINX   │
               └────┬─────┘
                    │
        ┌───────────┴───────────┐
        │                       │
   WordPress               MariaDB
      PHP-FPM                Database
        │                       │
        └───────────┬───────────┘
                    │
           Docker Bridge Network
                    │
        Persistent Docker Volumes
```

---

# Features

* Custom Docker images
* Docker Compose orchestration
* HTTPS with TLS
* Reverse proxy using NGINX
* MariaDB database
* WordPress with PHP-FPM
* Persistent storage
* Service isolation
* Automatic networking
* Infrastructure reproducibility

---

# Resources

## Docker Documentation

* Docker Official Documentation
* Docker Compose Documentation
* Dockerfile Reference
* Docker Networking Documentation
* Docker Volumes Documentation
* Docker Secrets Documentation

## NGINX

* Official NGINX Documentation

## MariaDB

* MariaDB Documentation

## WordPress

* WordPress Developer Documentation

## Linux

* Linux Filesystem Hierarchy Standard
* Debian Documentation

## AI Usage

Artificial intelligence was used as a supplementary learning tool during this project.

It was used for:

* Understanding Docker concepts and containerization.
* Clarifying Docker Compose configuration.
* Learning networking and volume management.
* Reviewing Dockerfiles and shell scripts.
* Improving the README documentation.
* Explaining system administration concepts.

All architecture decisions, implementation, debugging, configuration, and testing were completed manually. AI-generated explanations were verified against the official documentation before being incorporated into the project.

---

# License

This project was completed as part of the 42 curriculum and is intended for educational purposes.

