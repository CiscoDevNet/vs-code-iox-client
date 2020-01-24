FROM codercom/code-server

# For Now I am switching the USER back to root to make running docker in docker easier
USER root

# Installing Ubuntu Dependancies
RUN apt-get update && apt-get upgrade -y python3 && apt-get install -y python3-pip git

# Install code language dependancies
RUN pip3 install requests bottle

# Docker engine install
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" \
   && apt-get update && apt-get install -y docker-ce

# ioxclient install
#RUN curl -O https://pubhub.devnetcloud.com/media/iox/docs/artifacts/ioxclient/ioxclient-v1.7.2.1/ioxclient_1.7.2.1_linux_amd64.tar.gz \
#    && tar xvzf ioxclient_1.7.2.1_linux_amd64.tar.gz \
#    && chmod +x ioxclient_1.7.2.1_linux_amd64/ioxclient \
#    && cp ioxclient_1.7.2.1_linux_amd64/ioxclient /usr/local/bin/ioxclient

# ioxclient install from local file
COPY ioxclient_1.9.2.0_linux_amd64.tar.gz .
RUN tar xvzf ioxclient_1.9.2.0_linux_amd64.tar.gz \
    && chmod +x ioxclient_1.9.2.0_linux_amd64/ioxclient \
    && cp ioxclient_1.9.2.0_linux_amd64/ioxclient /usr/local/bin/ioxclient
COPY .ioxclientcfg.yaml /root/.ioxclientcfg.yaml


# Powershell install
RUN wget http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu55_55.1-7ubuntu0.4_amd64.deb \
    && apt install ./libicu55_55.1-7ubuntu0.4_amd64.deb \
    && wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt update && apt install -y powershell


# VS Code Extensions Install for code-server - Powershell Terminal Extension
RUN apt update && apt install -y bsdtar \
    && mkdir -p /root/.local/share/code-server/extensions \
    && curl -JL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/PowerShell/2019.5.0/vspackage | bsdtar -xvf - extension \
    && mv extension /root/.local/share/code-server/extensions/ms-vscode.powershell

# Coping start script
COPY start_codedock.sh /usr/local/bin/start_codedock.sh

RUN chmod +x /usr/local/bin/start_codedock.sh

RUN wget -O /usr/bin/k3s https://github.com/rancher/k3s/releases/download/v0.10.0/k3s
RUN chmod +x /usr/bin/k3s


ENTRYPOINT ["/usr/bin/dumb-init", "start_codedock.sh"]
