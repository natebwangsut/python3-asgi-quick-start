import multiprocessing

# Server socket
bind = "0.0.0.0:8000"

# Worker process
workers = multiprocessing.cpu_count()

# Web configuration
keepalive = 5

# Logging
errorlog = "-"
# loglevel = "error"
