# User Documentation

## Overview

This project deploys a complete WordPress website using Docker. Each service runs inside its own container and communicates through a private Docker network.

The stack provides the following services:

* **NGINX** – Reverse proxy serving the website over HTTPS.
* **WordPress** – Content Management System (CMS).
* **MariaDB** – Database used by WordPress.
* **Docker Volumes** – Persistent storage for the database and website files.

---

# Starting the Project

From the project root, run:

```bash
make
```

or

```bash
make up
```

This builds the Docker images (if necessary) and starts all containers.

---

# Stopping the Project

To stop the containers:

```bash
make down
```

To stop and remove all containers, images, and volumes:

```bash
make fclean
```

> **Warning:** `make fclean` deletes all persistent data stored in Docker volumes.

---

# Accessing the Website

After the project starts, open your browser and visit:

```
https://<your-domain>
```

or

```
https://localhost
```

depending on your configuration.

If using a custom domain, ensure it is correctly mapped in `/etc/hosts`.

---

# Accessing the WordPress Administration Panel

Open:

```
https://<your-domain>/wp-admin
```

Log in using the administrator account created during initialization.

---

# Credentials

Credentials are defined during project setup.

Depending on your implementation, they are stored in:

* Docker secrets
* Secret files
* Environment variables (`.env`)

Typical credentials include:

* WordPress administrator username
* WordPress administrator password
* Database name
* Database username
* Database password

Never commit sensitive credentials to Git.

---

# Checking the Services

List running containers:

```bash
docker ps
```
<<<<<<< HEAD

View all project containers:
=======
The command compose only works in the parentfolder of the yml file. View all project containers:
>>>>>>> 6acace4 (Changed the doc files)

```bash
docker compose ps
```

Check logs:

```bash
docker compose logs
```

View logs for a specific service:

```bash
docker compose logs nginx
docker compose logs wordpress
docker compose logs mariadb
```

If all containers show the **Up** status and the website loads successfully, the stack is operating correctly.

