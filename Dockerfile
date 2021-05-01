#-----------------------------#
# Dockerfile Build pqChecker  #
# by NoxInmortus              #
#-----------------------------#

FROM debian:buster-slim
LABEL maintainer='NoxInmortus'

ENV PQCHECKER_VERSION='2.0.0' \
    LDAP_VERSION='2.4.57'

ARG GITHUB_USER
ARG GITHUB_REPOSITORY
ARG GITHUB_TOKEN

ADD gh-push.sh /

RUN export ARCH=$(dpkg --print-architecture | awk -F- '{ print $NF }') \
  && mkdir -pv /usr/share/man/man1 /tmp/openldap \
  && echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -qy -t buster-backports apt-transport-https gnupg git gzip \
      curl openssl ca-certificates file gcc make checkinstall \
      libc6-dev libssl-dev libdb-dev libltdl-dev libsasl2-dev libsasl2-modules-ldap \
      libcurl3-gnutls=7.64.0-4+deb10u2 \
  && update-ca-certificates --fresh \
  && curl -sSLk --retry 5 https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
  && echo 'deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ buster main' >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -qy adoptopenjdk-11-hotspot \
  && curl -sSLk --retry 5 -O https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-${LDAP_VERSION}.tgz \
  && tar -xvzf openldap-${LDAP_VERSION}.tgz -C /tmp/openldap --strip-components=1 \
  && cd /tmp/openldap \
  && ./configure \
  && make depend \
  && git clone --depth 1 --single-branch --branch v${PQCHECKER_VERSION} https://bitbucket.org/ameddeb/pqchecker /tmp/pqchecker \
  && cd /tmp/pqchecker \
  && ./adjustdate.bash \
  &&  ./configure LDAPSRC=/tmp/openldap \
      JAVAHOME=/usr/lib/jvm/adoptopenjdk-11-hotspot-${ARCH} \
      libdir=/usr/lib/ldap \
      PARAMDIR=/etc/ldap/pqchecker \
  && make \
  && make install \
  && checkinstall -D --install=no -y --pkgname=pqchecker --pkgversion=${PQCHECKER_VERSION} --pkglicense='GNU GPL v3+ license' \
      --pakdir=/tmp --maintainer='NoxInmortus' --requires='slapd' \
  && chmod +x /gh-push.sh \
  && /gh-push.sh \
  ;

CMD ["/bin/bash"]
