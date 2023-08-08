# Step 0: Choose the BlackArch Linux base image
FROM blackarchlinux/blackarch

# Step 1: Set the environment variables using values from .env file
ENV TELEGRAM_API_KEY=${TELEGRAM_API_KEY}
ENV TELEGRAM_CHAT_ID=${TELEGRAM_CHAT_ID}

# Step 2: Install required dependencies using Pacman
RUN pacman -Sy --noconfirm \
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
    zaproxy \
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
    net-tools 
    # Add any other necessary dependencies here

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
    && go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest \
    && go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Step 5: Add Go bin to PATH
RUN echo 'export PATH=$PATH:/root/go/bin' >> ~/.bashrc

# Step 6: Set the working directory
WORKDIR /work_dir

# Step 7: Copy the file and folders into the container
COPY . .
COPY ./provider-config.yaml /root/.config/notify/provider-config.yaml

# Step 8: Install Anaconda Python
RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && \
    chmod +x Anaconda3-2021.05-Linux-x86_64.sh && \
    ./Anaconda3-2021.05-Linux-x86_64.sh -b -p /opt/anaconda3 && \
    rm Anaconda3-2021.05-Linux-x86_64.sh

# Step 9: Add Anaconda to PATH
ENV PATH="/opt/anaconda3/bin:${PATH}"

# Step 10: Define the entry point
ENTRYPOINT ["/bin/sh"]
