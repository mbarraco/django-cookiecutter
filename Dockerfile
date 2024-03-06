# Base stage for building and compiling
FROM python:3.11-alpine as base

# Combine update, installation of packages, and cleanup to reduce layers
RUN apk update && \
    apk add --no-cache python3-dev gcc musl-dev libpq-dev && \
    pip install --no-cache-dir pip-tools

# Set the working directory
WORKDIR /build

# Copy the requirements file for pip-compile
COPY requirements.* .

# Production stage starts here
FROM base as production

# Copy compiled requirements.txt from the base stage
COPY --from=base /build/requirements.txt .

# Install runtime dependencies if needed and Python packages
RUN apk add --no-cache libpq && \
    pip install --no-cache-dir -r requirements.txt

# Set the working directory for the application
WORKDIR /app

# Copy application files from host to container
COPY . /app

RUN echo 'alias ll="ls -l"' >> /etc/profile && source '/etc/profile'
# You may want to adjust the COPY command to specifically exclude or include certain files or directories
# Set ARGs and ENVs for configuration (your existing ARG and ENV setup here)
# Prepare application directory, add user, and set permissions (your existing RUN command for adding user and setting permissions here)
# Copy entrypoint and cmd scripts, and ensure they're executable
COPY docker-entrypoint.sh docker-cmd.sh /

RUN chmod +x /docker-entrypoint.sh /docker-cmd.sh

# Ensure runtime dependencies are met
RUN apk --no-cache add su-exec

WORKDIR /usr/src/website/website
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/docker-cmd.sh"]

EXPOSE $GUNICORN_PORT
