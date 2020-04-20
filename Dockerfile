FROM python

# Install apt-get packages
RUN apt-get update && \
    apt-get install -y \
        curl \
        apt-transport-https \
        ca-certificates \
        software-properties-common \
        apt-transport-https \
        gnupg2 \
        python3-dev \
        jq \
        git

# install pip packages
RUN pip install \
            awscli \
            cfn-lint \
            kustomize

# Install Helm 3
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install istioctl
RUN curl -sL https://istio.io/downloadIstioctl | sh -
ENV PATH=$PATH:$HOME/.istioctl/bin

# Install tfenv and terraform
RUN git clone https://github.com/Zordrak/tfenv.git /apps/tfenv && \
        ln -s /apps/tfenv/bin/* /usr/local/bin
RUN tfenv install 0.12.24 && tfenv use 0.12.24

WORKDIR /workdir
CMD /bin/bash
