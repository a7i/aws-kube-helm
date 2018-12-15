# Smallest base image
FROM alpine:3.8

LABEL author="a7i"

ADD VERSION .

RUN apk add --no-cache python \
  py-pip \
  py-setuptools \
  ca-certificates \
  groff \
  bash \
  libc6-compat \
  openrc \
  less \
  curl \
  openssl \
  bash \
  git \
  openssh-client \
  docker \
  && rc-update add docker boot \
  && rc-update add local boot \
  && wget -q https://storage.googleapis.com/kubernetes-release/release/v1.10.11/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && wget -q https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm \
  && pip --no-cache-dir install awscli==1.16.40 \
  && rm -rf /var/cache/apk/*

WORKDIR /config