#!/bin/bash
set -eu

dnf builddep -y $SPECFILE
mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
pkgname="$(rpmspec -q --qf="%{name}-%{version}-%{release}\n" $SPECFILE | head -n1)"
for s in $SOURCES
do
    if [[ -d $s ]]
    then
        if [[ -d $s/.git ]]
        then
            pushd $s
            git archive --prefix=${pkgname}/ --format=tar HEAD -o ~/rpmbuild/SOURCES/$pkgname.tar
            popd
        else
            ln -s $s $pkgname
            tar cvf ~/rpmbuild/SOURCES/$pkgname.tar $s/*
        fi
        gzip ~/rpmbuild/SOURCES/$pkgname.tar
    else
        cp $s ~/rpmbuild/SOURCES/
    fi
done
rpmbuild -ba $SPECFILE
