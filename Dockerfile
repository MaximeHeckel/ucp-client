FROM alpine:3.8

ARG KUBE_LATEST_VERSION="v1.12.1"
ARG DOCKER_CLI_VERSION="17.06.2-ce"
ARG DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLI_VERSION}.tgz"

# Install Docker client
RUN apk --update add curl unzip \
    && mkdir -p /tmp/download \
    && curl -L ${DOWNLOAD_URL} | tar -xz -C /tmp/download \
    && mv /tmp/download/docker/docker /usr/local/bin/ \
    && rm -rf /tmp/download

# Install Kubernetes client
RUN apk add --update ca-certificates \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && rm /var/cache/apk/* 

COPY init.sh /
RUN ["chmod", "+x", "/init.sh"]

CMD curl -L -k -H "Authorization: Bearer ${UCP_SESSION_TOKEN}" https://${UCP_HOST}/api/clientbundle/${UCP_USER} -o bundle.zip \
    && unzip bundle.zip \
    && sleep 24h