# Python3 ASGI Quick Start

Quick start template repository for Python 3 using ASGI

## WSGI vs ASGI

- WSGI: Web Server Gateway Interface
- ASGI: Asynchronous Server Gateway Interface

### ASGI is pretty much a superset of WSGI

> ASGI includes asynchronous serving methods while WSGI does not.

WSGI applications are a single, synchronous callable that takes a request and returns a response; this doesn’t allow for long-lived connections, like you get with long-poll HTTP or WebSocket connections.

Even if we made this callable asynchronous, it still only has a single path to provide a request, so protocols that have multiple incoming events (like receiving WebSocket frames) can’t trigger this.

### Concepts

You can read more on this per the following link: [Full ASGI PDF Documentation](https://readthedocs.org/projects/asgi/downloads/pdf/latest/)

## Frameworks

### FastAPI

- Asynchronous
- Performance
  - [Official Document on Performance](https://fastapi.tiangolo.com/benchmarks/)
  - [TechEmpower Benchmark Comparison [Python]](https://www.techempower.com/benchmarks/#section=data-r19&hw=ph&test=fortune&l=zijzen-1r)
- Easy to use
- Well documented

## Development

```console
$ gunicorn main:app -k uvicorn.workers.UvicornWorker -c uvicorn.conf.py --reload
[YYYY-MM-DD 00:00:00 +0000] [PID] [INFO] Starting gunicorn X.X.X
[YYYY-MM-DD 00:00:00 +0000] [PID] [INFO] Listening at: http://0.0.0.0:8000 (PID)
[YYYY-MM-DD 00:00:00 +0000] [PID] [INFO] Using worker: uvicorn.workers.UvicornWorker
```

Using gunicorn as process manager and uvicorn worker, the ASGI server is able to detect a change on Python code and automatically reload the server based on changes.

### Dependency Management

There're modern dependency management for Python

#### Pip

> TODO: Added content for pip

#### Pipenv

> TODO: Added content for pipenv

#### Poetry

> TODO: Added content for poetry

## Deployment

~~For the deployment process, this repository includes 3 prototypes which are production ready. All of prototypes are based on [GoogleContainerTools/distroless](https://github.com/GoogleContainerTools/distroless) container images.~~

With introduction of Python 3.9, distroless has not yet upgrade their Python to the current stable yet (currenly at 3.7), I've used `slim-buster` as an alternative for now until the distroless registry has caught up.
