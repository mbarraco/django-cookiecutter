# Django Cookiecutter Project

## Overview

This project is a Django-based application designed to be run in Docker containers, simplifying development, testing, and production deployment. It utilizes PostgreSQL for the database, Nginx for serving static and media files, and Traefik as a reverse proxy for HTTPS support.

## Getting Started

### Prerequisites

- Docker and Docker Compose installed on your machine.
- Basic knowledge of Docker, Django, and PostgreSQL.

### Setting Up for Development

1. **Build the Docker Containers**

   To build the base image and all service images:

   ```bash
   make build-base
   ```

2. **Initialize the Database**

   Before running the application for the first time, ensure the database is ready and migrations are applied:

   ```bash
   make migrate
   ```

3. **Collect Static Files**

   Collect Django static files:

   ```bash
   make collectstatic
   ```

4. **Run the Server**

   Start the development server:

   ```bash
   make runserver
   ```

   This command starts all necessary services defined in `docker-compose.yml`, including the Django application, PostgreSQL, Nginx, and Traefik.

### Using the Makefile Commands

The provided `Makefile` includes several commands to facilitate common tasks:

- `make bash`: Starts a bash session inside the Django container.
- `make bash-nginx`: Starts a bash session inside the Nginx container.
- `make collectstatic`: Collects static files using Django's `collectstatic` command.
- `make migrate`: Applies Django database migrations.
- `make migrations`: Generates new migrations based on changes to models.
- `make shell_plus`: Starts Django's `shell_plus` for advanced shell commands.
- `make restart`: Stops and then starts all containers, useful for refreshing configurations.
- `make logs`: Follows the log output from containers.

## Configurations

- **Django Settings**: Configured for development by default. Adjust `website/website/settings.py` for production, including `DEBUG` settings and allowed hosts.
- **Nginx**: Serves static and media files as configured in `nginx.conf`.
- **PostgreSQL**: Connection settings are managed through environment variables as defined in `.env` and referenced in `settings.py`.

## SSL/TLS Certificates

For production deployments, configure SSL/TLS certificates using Let's Encrypt as specified in `docker-compose.yml` for the Traefik service.

## Static and Media Files

- Static files are collected to and served from the `staticfiles` directory.
- Media files should be uploaded to and will be served from the `media` directory.

## Final Notes

Remember to review and customize the configurations, especially for production environments. Keep secret keys and sensitive data out of version control and manage them securely.
