# Step 0: Choose the Kali Linux base image for the build stage
FROM kalilinux/kali-rolling:latest AS build

# Step 1: Set the environment variables using values from .env file
ENV TELEGRAM_API_KEY=${TELEGRAM_API_KEY}
ENV TELEGRAM_CHAT_ID=${TELEGRAM_CHAT_ID}

# Step 0: Update and upgrade the system, and install required dependencies using APT
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    git \
    python3 \
    python3-pip \
    python3.11-venv \
    zsh \
    golang \
    nmap \
    zmap \
    amass \
    traceroute \
    sslscan \
    masscan \
    dirbuster \
    hydra \
    sqlmap \
    wget \
    net-tools \
    jq \
    awscli \
    nano \
    curl \
    ncat \
    exploitdb \
    gobuster \
    nikto \
    wpscan \
    dirb \
    responder \
    hping3 \
    netcat-traditional \
    metasploit-framework \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Go-related tools installation might need adjustments due to potential differences in package naming or availability in Kali
# Add this line before installing Go packages that require libpcap
RUN apt-get update && apt-get install -y libpcap-dev && rm -rf /var/lib/apt/lists/*

# Step 2: Install the Go scripts (Ensure to check compatibility with Kali Linux)
RUN go version 
RUN go install github.com/tomnomnom/assetfinder@latest 
RUN go install github.com/proditis/orunmila@latest 
RUN go install github.com/proditis/mini-tools/cspparse@latest 
RUN go install github.com/proditis/mini-tools/certnames@latest 
RUN go install github.com/proditis/mini-tools/sniprobe@latest 
RUN go install github.com/outersky/har-tools/cmd/harx@latest 
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest 
RUN go install -v github.com/projectdiscovery/notify/cmd/notify@latest 
RUN go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest 
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest 
RUN go install github.com/ffuf/ffuf/v2@latest 
RUN go install github.com/tomnomnom/waybackurls@latest 
RUN go install github.com/channyein1337/jsleak@latest 
RUN go install github.com/sw33tLie/sns@latest  
RUN go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

# GO111MODULE=on might still be needed for some Go packages
RUN GO111MODULE=on go install dw1.io/go-dork@latest

# Step 3: Add Go bin to PATH
RUN echo 'export PATH=$PATH:/root/go/bin' >> ~/.bashrc

# Step 4: Set the working directory
WORKDIR /work_dir

# Step 5: Copy the files and folders into the container
COPY . .

# Use a separate stage for runtime to keep the final image smaller
FROM kalilinux/kali-rolling:latest AS runtime

# Copy necessary binaries and configurations from the build stage
COPY --from=build /root /root
COPY --from=build /usr /usr
COPY --from=build /etc /etc
COPY --from=build /lib /lib
COPY --from=build /lib64 /lib64
COPY --from=build /opt /opt
COPY --from=build /work_dir /work_dir

WORKDIR /work_dir

# The rest of the commands for configuring the runtime environment remain largely the same but ensure all commands are compatible with Kali Linux.

# Additional Kali-specific configurations may be added here
# Install OpenSSH and create the missing directory
RUN apt-get update && apt-get install -y openssh-server && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/sshd

# Generate SSH host keys
RUN ssh-keygen -A

# Download and install GoTTY
RUN wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz -O gotty.tar.gz \
    && tar -xzf gotty.tar.gz \
    && mv gotty /usr/local/bin/ \
    && rm gotty.tar.gz

# Generate a self-signed SSL certificate
RUN openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj '/CN=localhost'
COPY ./provider-config.yaml /root/.config/notify/provider-config.yaml

# Set JAVA_HOME and PATH for Java. Adjust if using a different Java version.
#RUN apt-get update && apt-get install -y openjdk-11-jdk && rm -rf /var/lib/apt/lists/* \
#    && echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> ~/.bashrc \
#    && echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

# Apply bashrc changes without needing to log out and back in
RUN . ~/.bashrc
EXPOSE 22 8080 8090
COPY ./update_telegram_config.sh /usr/local/bin/update_telegram_config
RUN chmod +x /usr/local/bin/update_telegram_config
RUN echo 'root:blackcart' | chpasswd

# Configure sshd to allow root login with password
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

ARG USER="blackdagger"
ARG USER_UID=1000
ARG USER_GID=$USER_UID



RUN /bin/bash -c ' \
    # User and permissions setup \
    apt-get update && \
    apt-get install -y sudo tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g ${USER_GID} ${USER} && \
    useradd -m -s /bin/bash -u ${USER_UID} -g ${USER_GID} ${USER} && \
    echo "${USER} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER} \
'

ENV BLACKDAGGER_HOST=0.0.0.0
ENV BLACKDAGGER_PORT=8080
RUN curl -L https://raw.githubusercontent.com/ErdemOzgen/blackdagger/main/scripts/downloader.sh | bash
RUN python3 -m venv blackcartenv
#RUN echo 'source blackcartenv/bin/activate' >> ~/.zshrc
#RUN source ~/.zshrc
RUN echo 'source blackcartenv/bin/activate' >> ~/.bashrc
RUN source ~/.bashrc

# Example for adding entrypoint
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
