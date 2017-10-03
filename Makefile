DOCKERFILES = fedora/Dockerfile-25 fedora/Dockerfile-26 centos/Dockerfile-7
BUILDFILES = fedora/Dockerfile-25.build fedora/Dockerfile-26.build centos/Dockerfile-7.build

dockerfiles: $(DOCKERFILES)

dockerbuild: $(BUILDFILES)

fedora/Dockerfile-25.build: fedora/Dockerfile-25 fedora/build.sh
	docker build -t docker-builder/fedora:25 -f $< fedora/
	touch $@

fedora/Dockerfile-26.build: fedora/Dockerfile-26 fedora/build.sh
	docker build -t docker-builder/fedora:26 -f $< fedora/
	touch $@

centos/Dockerfile-7.build: centos/Dockerfile-7 centos/build.sh
	docker build -t docker-builder/centos:7 -f $< centos/
	touch $@

fedora/Dockerfile-25: fedora/Dockerfile.tmpl
	sed 's/@DISTVERSION@/25/g' $< > $@

fedora/Dockerfile-26: fedora/Dockerfile.tmpl
	sed 's/@DISTVERSION@/26/g' $< > $@

centos/Dockerfile-7: centos/Dockerfile.tmpl
	sed 's/@DISTVERSION@/7/g' $< > $@

clean:
	$(RM) $(DOCKERFILES)
	$(RM) $(BUILDFILES)
