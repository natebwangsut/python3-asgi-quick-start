# Build a virtualenv using the appropriate Debian release
# * Install python3-venv for the built-in Python3 venv module (not installed by default)
# * Install gcc libpython3-dev to compile C Python modules
# * Update pip to support bdist_wheel

# FROM debian:buster-slim AS build
FROM python:3.9-slim-buster AS build

# Skip post installs prompts
ENV DEBIAN_FRONTEND=noninteractive

# Python lib
RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
        gcc \
        # python3-dev \
        # python3-venv \
        libpython3-dev \
        # SSL + TLS
        libssl-dev \
        && \
    python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip poetry

################################################################################

# Build the virtualenv as a separate step
# Only re-execute this step when requirements.txt changes
FROM build AS build-venv

# Setting these environment variables are the same as running
# source /env/bin/activate.
ENV VIRTUAL_ENV /venv
ENV PATH /venv/bin:$PATH

ENV POETRY_VIRTUALENVS_CREATE=false
ENV POETRY_VIRTUALENVS_PATH=/venv
ENV POETRY_VIRTUALENVS_IN_PROJECT=/venv

COPY poetry.lock    /poetry.lock
COPY pyproject.toml /pyproject.toml

RUN /venv/bin/poetry install

################################################################################

# Copy the virtualenv into a distroless image
# TODO: Change slim to distroless image once 3.9 is ready
FROM python:3.9-slim-buster

#
ARG VERSION

# Labels
LABEL maintainer="Maintainer <maintainer@email.com>"

# Not holding stdout data in buffer, resulting in more robust logging
ENV PYTHONUNBUFFERED=1

COPY --from=build-venv /venv /venv
COPY . /app

USER 65534
WORKDIR /app
# ENTRYPOINT ["/venv/bin/uvicorn", "main:app", "--host", "0.0.0.0"]
ENTRYPOINT ["/venv/bin/gunicorn", "main:app", "-k", "uvicorn.workers.UvicornWorker", "-c", "uvicorn.conf.py"]
