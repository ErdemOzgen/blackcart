# Step 0: Choose the BlackArch Linux base image for the build stage
FROM blackarchlinux/blackarch:latest AS build

# Step 1: Set the environment variables using values from .env file
ENV TELEGRAM_API_KEY=${TELEGRAM_API_KEY}
ENV TELEGRAM_CHAT_ID=${TELEGRAM_CHAT_ID}

# Step 0: Initialize keyring and populate Arch Linux keyring
RUN pacman-key --init && pacman-key --populate archlinux

# Step 1: Update the Arch Linux keyring and upgrade the system
RUN pacman -Sy --noconfirm archlinux-keyring && pacman -Syu --noconfirm



# Step 2: Upgrade the system and install required dependencies using Pacman
RUN pacman -Syu --noconfirm \
    base-devel \
    git \
    python \
    python-pip \
    go \
    nmap \
    rustscan \
    zmap \
    amass \
    gau \
    traceroute \
    sslscan \
    massdns \
    altdns \
    httprobe \
    masscan \
    hosthunter \
    gobuster \
    dirsearch \
    hydra \
    gospider \
    xsstrike \
    ssrf-sheriff \
    ssrfmap \
    corscanner \
    crlfuzz \
    sqlmap \
    wget \
    net-tools \
    jq \
    aws-cli \
    arjun \
    theharvester \
    dirb \
    pcre \
    pkg-config \
    gitleaks \
    wapiti \
    nano \
    dalfox \
    s3scanner \
    feroxbuster \
    iis-shortname-scanner \
    nikto \
    dnswalk \
    dnsenum \
    bind \
    evil-winrm  \
    socat \
    chisel \
    metasploit \
    dnsprobe \
    qsreplace \
    hakrawler \
    puredns \
    parallel


# Step 3: Set the working directory
WORKDIR /go/src/app

# Step 4: Install the Go scripts
RUN go version \
    && go install github.com/tomnomnom/assetfinder@latest \
    && go install github.com/proditis/orunmila@latest \
    && go install github.com/proditis/mini-tools/cspparse@latest \
    && go install github.com/proditis/mini-tools/certnames@latest \
    && go install github.com/proditis/mini-tools/sniprobe@latest \
    && go install github.com/outersky/har-tools/cmd/harx@latest \
    && go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest \
    && go install -v github.com/projectdiscovery/notify/cmd/notify@latest \
    && go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest \
    && go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest \
    && go install github.com/ffuf/ffuf/v2@latest \
    && go install github.com/tomnomnom/waybackurls@latest \
    && go install github.com/channyein1337/jsleak@latest \
    && go install github.com/sw33tLie/sns@latest  \
    && go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest \
    && go install github.com/tomnomnom/gf@latest \
    && go install -v github.com/tomnomnom/anew@latest \
    && go install github.com/projectdiscovery/katana/cmd/katana@latest


# Step 4.1: Install with GO111MODULE=on
RUN GO111MODULE=on go install dw1.io/go-dork@latest

# Step 5: Add Go bin to PATH
RUN echo 'export PATH=$PATH:/root/go/bin' >> ~/.bashrc

# Step 6: Set the working directory
WORKDIR /work_dir

# Step 7: Copy the file and folders into the container
COPY . .


# RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && \
#     chmod +x Anaconda3-2021.05-Linux-x86_64.sh && \
#     ./Anaconda3-2021.05-Linux-x86_64.sh -b -p /opt/anaconda3 && \
#     rm Anaconda3-2021.05-Linux-x86_64.sh

# Use a separate stage for runtime to keep the final image smaller
FROM blackarchlinux/blackarch:latest AS runtime

# Copy the Anaconda installation from the build stage
#COPY --from=build /opt/anaconda3 /opt/anaconda3
#Copy all binaries from the builder image to the runtime image
COPY --from=build /root/go/bin /root/go/bin
COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/sbin /usr/local/sbin
COPY --from=build /usr/bin /usr/bin
COPY --from=build /usr/sbin /usr/sbin
COPY --from=build /go/src/app /go/src/app
COPY --from=build /usr /usr
COPY --from=build /lib /lib
COPY --from=build /lib64 /lib64
COPY --from=build /opt /opt
#COPY --from=build / /

#  Initialize keyring and populate Arch Linux keyring
RUN pacman-key --init && pacman-key --populate archlinux

#  Update the Arch Linux keyring and upgrade the system
#RUN pacman -Sy --noconfirm archlinux-keyring && pacman -Syu --noconfirm
# Set the PATH for Miniconda
#RUN echo 'export PATH=$PATH:/opt/anaconda3/bin' >> ~/.bashrc

#RUN pacman -Sy --noconfirm --overwrite '*' jre11-openjdk
RUN pacman -Sy --noconfirm --overwrite '*' jdk11-openjdk
RUN pacman -Sy --noconfirm --overwrite '*' python-shodan
RUN pacman -Sy --noconfirm --overwrite '*' python-censys
WORKDIR /work_dir
# Add smuggler
RUN git clone https://github.com/defparam/smuggler.git
WORKDIR /root
RUN git clone https://github.com/1ndianl33t/Gf-Patterns
RUN cp ~/go/bin/gf /bin/
RUN mkdir ~/.gf
RUN mv ~/Gf-Patterns/*.json ~/.gf
WORKDIR /work_dir
# For WebAnalyzer pull this docker and run as API endpoint ==> docker pull erdemozgen/wap_api
# Set the entry point to /bin/bash
RUN echo 'export PATH="/root/go/bin:/sbin:/usr/bin:/root/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/bin:/usr/bin/core_perl:$PATH"' >> ~/.bashrc
RUN python -m venv blackcartenv
#RUN echo 'source blackcartenv/bin/activate' >> ~/.bashrc
RUN echo "alias install='pacman -S --noconfirm --overwrite \"*\"'" >> ~/.bashrc
RUN echo "alias update='pacman -Syu --noconfirm --overwrite \"*\"'" >> ~/.bashrc
RUN echo "alias remove='pacman -R --noconfirm'" >> ~/.bashrc
RUN echo "alias search='pacman -Ss'" >> ~/.bashrc
RUN source ~/.bashrc
RUN pacman -Sy --noconfirm --overwrite '*' openssh
# Generate SSH host keys
RUN ssh-keygen -A

RUN wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz -O gotty.tar.gz \
    && tar -xzf gotty.tar.gz \
    && mv gotty /usr/local/bin/ \
    && rm gotty.tar.gz


# Generate a self-signed SSL certificate
RUN openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj '/CN=localhost'
COPY ./provider-config.yaml /root/.config/notify/provider-config.yaml
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk' >> ~/.bashrc
RUN echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
RUN source ~/.bashrc
COPY ./update_telegram_config.sh /usr/local/bin/update_telegram_config
RUN chmod +x /usr/local/bin/update_telegram_config

# Move the certificate and key to a specific directory (optional)
RUN mkdir -p /etc/gotty && mv cert.pem key.pem /etc/gotty/
RUN mkdir -p /work_dir/scan_data
RUN source ~/.bashrc

# Set blackdagger user password
# ARG USER="blackdagger"
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID
ENV BLACKDAGGER_HOST=0.0.0.0
ENV BLACKDAGGER_PORT=8080

# RUN /bin/bash -c ' \
#     # Update the system and install sudo, handling file conflicts \
#     pacman -Syu --noconfirm --overwrite "*" && \
#     pacman -S --noconfirm --overwrite "*" sudo && \
#     # Clean the package cache to reduce image size \
#     pacman -Scc --noconfirm && \
#     # User and permissions setup, checking if group/user already exists \
#     if ! getent group ${USER_GID}; then \
#         groupadd -g ${USER_GID} ${USER}; \
#     fi; \
#     if ! id -u ${USER} > /dev/null 2>&1; then \
#         useradd -m -s /bin/bash -u ${USER_UID} -g ${USER_GID} ${USER}; \
#     fi; \
#     echo "${USER} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USER} && \
#     chmod 0440 /etc/sudoers.d/${USER} \
# '

RUN source /work_dir/blackcartenv/bin/activate && pip3 install uro && pip3 install arjun


RUN curl -L https://raw.githubusercontent.com/ErdemOzgen/blackdagger/main/scripts/downloader.sh | bash
RUN pacman -Sy --noconfirm --overwrite '*' zip
RUN pacman -Sy --noconfirm --overwrite '*' unzip
#RUN bash <(curl -fsSL https://raw.githubusercontent.com/osmedeus/osmedeus-base/master/install.sh)
#RUN go install -v github.com/j3ssie/osmedeus@latest
# Install Python packages via pacman
#RUN pacman -Syu --noconfirm python-setuptools python-wheel
# Install pipx
# RUN pacman -Syu --noconfirm python-pipx

# # Use pipx to install applications
# RUN pip3 install aiohttp
# RUN pipx install wapiti3

#RUN pacman -Syu --noconfirm wapiti
# RUN wget https://github.com/wapiti-scanner/wapiti/releases/download/3.1.7/wapiti3-3.1.7.tar.gz && \
#     tar -xzvf wapiti3-3.1.7.tar.gz && \
#     cd wapiti3-3.1.7 && \
#     source /work_dir/blackcartenv/bin/activate && \
#     pip3 install . && \
#     cd .. && \
#     rm -rf wapiti*


EXPOSE 8080 8090

COPY ./entrypoint.sh /entrypoint.sh
COPY ./startservices.sh /startservices.sh
COPY update_telegram_config.sh /usr/local/bin/update_telegram_config
RUN mv /work_dir/blackdagger /usr/local/bin/blackdagger
RUN sh -c 'cp /root/go/bin/* /usr/bin/'
RUN source ~/.bashrc
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
