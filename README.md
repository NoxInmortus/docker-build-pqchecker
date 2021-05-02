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

Supported architectures are :

- linux/amd64
- linux/arm64/v8
- linux/ppc64le
- linux/s390x
- linux/386
- linux/arm/v6
- linux/arm/v7
- linux/mips64le

## Dockerfile.openjdk

This image uses the `openjdk-11-jdk` package by default but there is a unresolved bug with it for `linux/s390x` and `linux/ppc64le` architectures. To solve that, those two architectures use `adoptopenjdk-11-hotspot` package.

## References :

- Missing build dependencies : https://arand263.blogspot.com/2011/11/debian-squeeze-installer-un-serveur.html
- jdk-11 not installing because of missing directory : https://github.com/geerlingguy/ansible-role-java/issues/64
- Binary used for building deb packages : https://manpages.debian.org/buster-backports/checkinstall/checkinstall.8.en.html
- Push github releases through curl : https://medium.com/@systemglitch/continuous-integration-with-jenkins-and-github-release-814904e20776

## [License](LICENSE)
GNU GPL v3+
