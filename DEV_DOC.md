# Developer Documentation

## Prerequisites

Before building the project, install:

* Docker
* Docker Compose
* GNU Make
* Git

Verify the installation:

```bash
docker --version
docker compose version
make --version
```

---

# Project Structure

A typical project layout is:

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
└── srcs
    ├── docker-compose.yml
    ├── .env
    └── requirements
        ├── nginx
        ├── mariadb
        └── wordpress
```

---

# Configuration

Configuration is stored in:

* `docker-compose.yml`
* `.env`
* Dockerfiles
* Service configuration files
* Secret files (if used)

Before running the project, update the required variables such as:

* Domain name
* Database name
* Database user
* Database password
* WordPress administrator credentials

---

# Building the Project

Build all images:

```bash
make
```

or

```bash
docker compose up --build
```

---

# Launching the Stack

Start the services:

```bash
make up
```

or

```bash
docker compose up -d
```

---

# Stopping the Stack

```bash
make down
```

or

```bash
docker compose down
```

---

# Useful Docker Commands

Show running containers:

```bash
docker ps
```

Show all containers:

```bash
docker ps -a
```

List Docker images:

```bash
docker images
```

List volumes:

```bash
docker volume ls
```

Inspect the Docker network:

```bash
docker network ls
```

Open a shell inside a container:

```bash
docker exec -it <container_name> sh
```

View logs:

```bash
docker compose logs
```

Restart a service:

```bash
docker compose restart <service>
```

Rebuild a service:

```bash
docker compose up --build <service>
```

---

# Data Persistence

The project uses **Docker volumes** to preserve data between container restarts.

Typical persistent data includes:

* WordPress files
* MariaDB database

Docker stores named volumes under its managed storage directory (commonly `/var/lib/docker/volumes/` on Linux). Since volumes are managed by Docker, data remains available even if containers are recreated.

To list available volumes:

```bash
docker volume ls
```

To inspect a volume:

```bash
docker volume inspect <volume_name>
```

Removing a volume permanently deletes the stored data.

---

# Development Workflow

A common development workflow is:

1. Modify a Dockerfile or configuration file.
2. Rebuild the affected service.
3. Restart the containers.
4. Verify functionality using logs and the website.

---

# Troubleshooting

If the project fails to start:

1. Check that Docker is running.
2. Verify the `.env` file or secrets.
3. Inspect the container logs.
4. Ensure the required ports are available.
5. Rebuild the affected images.

Useful commands:

```bash
docker compose logs
docker compose ps
docker compose config
```

These commands help identify configuration and runtime issues quickly.

