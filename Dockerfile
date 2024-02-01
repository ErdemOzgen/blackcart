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
    wfuzz \
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
    iis-shortname-scanner




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
    && go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

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

RUN pacman -Sy --noconfirm --overwrite '*' jre11-openjdk
RUN pacman -Sy --noconfirm --overwrite '*' jdk11-openjdk
RUN pacman -Sy --noconfirm --overwrite '*' python-shodan
RUN pacman -Sy --noconfirm --overwrite '*' python-censys
WORKDIR /work_dir
# Add smuggler
RUN git clone https://github.com/defparam/smuggler.git
# For WebAnalyzer pull this docker and run as API endpoint ==> docker pull erdemozgen/wap_api
# Set the entry point to /bin/bash
RUN echo 'export PATH="/root/go/bin:/sbin:/usr/bin:/root/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/bin:/usr/bin/core_perl:$PATH"' >> ~/.bashrc
RUN python -m venv blackcartenv
RUN echo 'source blackcartenv/bin/activate' >> ~/.bashrc
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
RUN pip install PyYAML
RUN pip install --upgrade pip
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk' >> ~/.bashrc
RUN echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
RUN source ~/.bashrc
COPY ./set_notify.py /usr/local/bin/update_telegram_config
RUN chmod +x /usr/local/bin/update_telegram_config

# Move the certificate and key to a specific directory (optional)
RUN mkdir -p /etc/gotty && mv cert.pem key.pem /etc/gotty/
RUN mkdir -p /work_dir/data
RUN source ~/.bashrc
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
