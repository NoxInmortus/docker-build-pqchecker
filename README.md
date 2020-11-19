# Docker-build-pqchecker

pqChecker is an OpenLDAP password policy pwdCheckModule.

This repository aims to deliver missing pqChecker packages architectures as the official release is only available for amd64.

All credits goes to Abdelamid Meddeb, maintainer of pqChecker :
- Official repository : https://bitbucket.org/ameddeb/pqchecker
- Official website : https://www.meddeb.net/pqchecker

## Official NoxInmortus repositories

Find more at :
- https://hub.docker.com/u/noxinmortus
- https://git.tools01.imperium-gaming.fr/public
- https://github.com/NoxInmortus?tab=repositories

## Available Architectures

Chosen architectures are the supported architectures from the Debian official image, as it is used as the base image.

- linux/386
- linux/amd64
- linux/arm/v5 : KO (not available yet)
- linux/arm/v7
- linux/arm64/v8
- linux/mips64le
- linux/ppc64le
- linux/s390x

## Dockerfile.openjdk

The Dockerfile uses the `adoptopenjdk-11-hotspot` package by default because there is a unresolved bug with `openjdk-11-jdk` package for the `linux/s390x` and `linux/ppc64le` architectures.

Unfortunately the `adoptopenjdk-11-hotspot` package is not available for `linux/386` and `linux/mips64le` architectures. A secondary Dockerfile named `Dockerfile.openjdk` is used for the builds, and use `openjdk-11-jdk` instead.

## References :

- Missing build dependencies : https://arand263.blogspot.com/2011/11/debian-squeeze-installer-un-serveur.html
- jdk-11 not installing because of missing directory : https://github.com/geerlingguy/ansible-role-java/issues/64
- Binary used for building deb packages : https://manpages.debian.org/buster-backports/checkinstall/checkinstall.8.en.html
- Push github releases through curl : https://medium.com/@systemglitch/continuous-integration-with-jenkins-and-github-release-814904e20776

## [License](LICENSE)
GNU GPL v3+
