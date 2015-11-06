# Computer vision environment for Python

To build the docker container:

```
cd /path/to/cvpy
docker build -t cvpy .
```

When you run it you will need to expose port 8888 and you will probably want to mount a data volume. For example:

```
docker run -d -p 8888:8888 -v /path/to/folder:/data cvpy
```

On OS X, you can find the IP address to the default docker VM with:

```
docker-machine ip default
```

To access the Jupyter notebook, point your browser to port 8888 at that IP. You can also override the `CMD` and use this container as a base image in another project.
