# Python 3 Quick Start

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
  - [Techempower Benchmark Comparison [Python]](https://www.techempower.com/benchmarks/#section=data-r19&hw=ph&test=fortune&l=zijzen-1r)
- Easy to use
- Well documented

### Uvicorn

- Why not gunicorn as well?

> Since we're running in Docker, the only process that gunicorn needed to manage is the ASGI application itself.

- But gunicorn has a better threading models

> The argument is unrefutable, however gunicorn comes with the significant overhead of deployment. You can read more [here](https://www.uvicorn.org/deployment/#gunicorn)

## Development

```console
uvicorn main:app --reload
```

Using uvicorn, the ASGI server is able to detect a change on Python code and automatically reload the server based on changes.

## Deployment

For the deployment process, this repository includes 3 prototypes which are production ready. All of prototypes are based on [GoogleContainerTools/distroless](https://github.com/GoogleContainerTools/distroless) container images.

Only the installation method is different between each container. Python has introduced `pipenv` which are useful for managing multiple environments. For standard installation, a normal `venv` with `pip` is provided as well.
