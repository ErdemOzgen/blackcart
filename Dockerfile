# Step 0: Choose the BlackArch Linux base image for the build stage
FROM blackarchlinux/blackarch AS build

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

# Step 8: Install Miniconda for the runtime stage
# Step 8: Install Miniconda for the runtime stage
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    chmod +x miniconda.sh && \
    ./miniconda.sh -b -p /opt/miniconda3 && \
    rm miniconda.sh

# Use a separate stage for runtime to keep the final image smaller
FROM blackarchlinux/blackarch AS runtime

# Copy the Miniconda installation from the build stage
COPY --from=build /opt/miniconda3 /opt/miniconda3
# Copy all binaries from the builder image to the runtime image
COPY --from=build /root/go/bin /root/go/bin
COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/sbin /usr/local/sbin
COPY --from=build /go/src/app /go/src/app

# Set the PATH for Miniconda
RUN echo 'export PATH=$PATH:/opt/miniconda3/bin' >> ~/.bashrc

# Set the entry point to /bin/bash
RUN echo 'export PATH="/root/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/bin:/usr/bin/core_perl:/usr/games/bin:/root/go/bin:/opt/miniconda3/bin:$PATH"' >> ~/.bashrc
RUN source ~/.bashrc
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]