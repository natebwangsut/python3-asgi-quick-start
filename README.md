# Python 3 Quick Start

Quick start template repository for Python 3 using ASGI

## WSGI vs ASGI

- WSGI: Web Server Gateway Interface
- ASGI: Asynchronous Server Gateway Interface

**ASGI is pretty much a superset of WSGI**

> ASGI includes asynchronous serving methods while WSGI does not.

WSGI applications are a single, synchronous callable that takes a request and returns a response; this doesn’t allow for long-lived connections, like you get with long-poll HTTP or WebSocket connections.

Even if we made this callable asynchronous, it still only has a single path to provide a request, so protocols that have multiple incoming events (like receiving WebSocket frames) can’t trigger this.

### Concepts

You can read more on this per the following link: https://readthedocs.org/projects/asgi/downloads/pdf/latest/

### FastAPI

- Performance

> https://fastapi.tiangolo.com/benchmarks/

### Uvicorn

- Why not gunicorn as well?

> Since we're running in Docker, the only process that gunicorn needed to manage is the ASGI application itself.

- But gunicorn as a better threading models

> In that case, gunicorn is very usable

## Running Application (Development)

```console
uvicorn main:app
```
