# Smallest base image
FROM alpine:3.8

LABEL author="a7i"

ADD VERSION .
ENV KUBECTL_VERSION 1.11.5
ENV HELM_VERSION 2.12.0

RUN apk add --no-cache python \
  g++ \
  make \
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
  jq \
  && rc-update add docker boot \
  && rc-update add local boot \
  && pip --no-cache-dir install awscli==1.16.40 \
  && rm -rf /var/cache/apk/*

# Install kubectl
RUN curl -s -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
  && chmod +x /usr/bin/kubectl

# Install Helm
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
  -o /usr/bin/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
  && tar xvzf /usr/bin/helm-v${HELM_VERSION}-linux-amd64.tar.gz -C /tmp/ \
  && mv /tmp/linux-amd64/helm /usr/bin \
  && chmod +x /usr/bin/helm \
  && helm init --client-only

# Install aws-iam-authenticator
RUN curl -s -L -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator \
  && chmod +x /usr/bin/aws-iam-authenticator


WORKDIR /config