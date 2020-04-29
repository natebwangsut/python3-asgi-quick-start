################################################################################

FROM python:3.8-alpine

LABEL maintainer="<maintainer@email.com>"

# Not holding stdout data in buffer, resulting in more robust logging
ENV PYTHONUNBUFFERED=1

EXPOSE 8000
WORKDIR /app

COPY . ./

# Install build dependencies and remove it after installing
# PyPI packages from requirements.txt
#
# By running installation and removal in the same line
# the container size is significantly optimised
RUN set -eux && apk add --no-cache --virtual .build-deps \
    gcc \
    libc-dev \
    make \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
