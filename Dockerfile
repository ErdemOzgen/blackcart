# Step 1: Choose the BlackArch Linux base image
FROM blackarchlinux/blackarch

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
    crlfuzz

# Step 3: Set the working directory
WORKDIR /go/src/app

# Step 4: Copy the Go scripts into the container
#COPY . .
#COPY ./provider-config.yaml /root/.config/notify/provider-config.yaml

# Step 5: Install the Go scripts
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

# Step 6: Add Go bin to PATH
RUN echo 'export PATH=$PATH:/root/go/bin' >> ~/.bashrc

# Step 7: Define the entry point
ENTRYPOINT ["bash"]
