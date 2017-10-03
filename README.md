# docker builder

Build RPM in Fedora and CentOS.

# Example

Build the images:

```
make
```

Build CentOS 7 package of the project with path `/path/to/git`:

```
$ docker run -w /path/to/git/:/src -e SPECFILE=/src/myspec.spec -e SOURCES="/src /src/fedora.patch" docker-builder/centos:7
```
