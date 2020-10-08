# Build a virtualenv using the appropriate Debian release
# * Install python3-venv for the built-in Python3 venv module (not installed by default)
# * Install gcc libpython3-dev to compile C Python modules
# * Update pip to support bdist_wheel
FROM debian:buster-slim AS build
RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes python3-venv gcc libpython3-dev && \
    python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip pipenv

################################################################################

# Build the virtualenv as a separate step
# Only re-execute this step when requirements.txt changes
FROM build AS build-venv

# Setting these environment variables are the same as running
# source /env/bin/activate.
ENV VIRTUAL_ENV /venv
ENV PATH /venv/bin:$PATH

COPY Pipfile /Pipfile
COPY Pipfile.lock /Pipfile.lock
RUN /venv/bin/pipenv install -e .

################################################################################

# Copy the virtualenv into a distroless image
FROM gcr.io/distroless/python3-debian10

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
ENTRYPOINT ["/venv/bin/uvicorn", "main:app", "--host", "0.0.0.0"]
