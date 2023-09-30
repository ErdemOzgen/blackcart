  <p align="center"><a href="https://github.com/ErdemOzgen/blackcart">Blackcart</a> Continuous Automated Red Teaming Dockerfile</p>
    <p align="center">
    <a href="https://github.com/erdemozgen/blackcart/actions/workflows/build-and-push.yaml" alt="Publish Docker Image">
          <img src="https://img.shields.io/github/actions/workflow/status/erdemozgen/blackcart/build-and-push.yaml" /></a>
    <a href="http://doge.mit-license.org" alt="License">
          <img src="http://img.shields.io/:license-mit-blue.svg" /></a>
    <a href="https://hub.docker.com/r/erdemozgen/blackcart/" alt="Docker image size">
          <img src="https://img.shields.io/docker/image-size/erdemozgen/blackcart/latest" /></a>
    <a href="https://hub.docker.com/r/erdemozgen/blackcart/" alt="Docker Pulls">
          <img src="https://img.shields.io/docker/pulls/erdemozgen/blackcart" /></a>
  </p>

# Docker Container for Continuous Automated Red Teaming

Continuous automated red teaming (CART) is an advanced cybersecurity approach that incorporates automation and continuous testing into traditional red team exercises. Unlike manual red teaming conducted annually or bi-annually, CART ensures ongoing security testing throughout the year. By continuously testing an organization's cybersecurity defenses, CART aims to detect and address vulnerabilities proactively, preventing attackers from exploiting them. This method provides a more proactive and comprehensive approach to enhancing an organization's security posture. Blackcart is a streamlined Dockerfile that comprises a collection of essential security tools suitable for Continuous Automated Red Teaming (CART).

## Installed Tools


| Name               | Description                                  |
| ------------------ | -------------------------------------------- |
| git                | Version control system                       |
| python             | Programming language                         |
| python-pip         | Python package manager                       |
| go                 | Programming language                         |
| nmap               | Network exploration tool                     |
| rustscan           | Fast port scanner                            |
| zmap               | Network scanner for open ports               |
| amass              | Subdomain enumeration tool                   |
| gau                | Fetch known URLs from AlienVault's OTX      |
| traceroute         | Network diagnostic tool                      |
| sslscan            | SSL/TLS security testing tool                |
| massdns            | DNS resolver and list generator              |
| altdns             | Subdomain permutation tool                   |
| httprobe           | HTTP/HTTPS probe                             |
| masscan            | Fast port scanner                            |
| hosthunter         | Subdomain discovery tool                     |
| gobuster           | Directory/file brute-forcing tool            |
| dirsearch          | Web path scanner                             |
| hydra              | Password cracking tool                       |
| gospider           | Web spider and crawler                       |
| xsstrike           | XSS scanner                                  |
| ssrf-sheriff       | Server-Side Request Forgery (SSRF) scanner   |
| ssrfmap            | Server-Side Request Forgery (SSRF) scanner   |
| corscanner         | CORS misconfiguration scanner                |
| crlfuzz            | CRLF injection vulnerability scanner         |
| sqlmap             | SQL injection scanner                        |
| wget               | Network utility to retrieve files            |
| net-tools          | Network configuration tools                  |
| jq                 | Command-line JSON processor                  |
| aws-cli            | AWS Command Line Interface                   |
| wfuzz              | Web application brute-forcing tool           |
| arjun              | Parameter-based request tool                 |
| theharvester       | Information gathering tool                   |
| assetfinder        | Subdomain finder tool                        |
| orunmila           | DNS brute-forcing tool                       |
| cspparse           | Content Security Policy (CSP) parser         |
| certnames          | Extract SSL/TLS certificate names            |
| sniprobe           | Subdomain enumeration tool                   |
| harx               | HTTP Archive (HAR) file extractor            |
| subfinder          | Subdomain discovery tool                     |
| notify             | Notification service for security findings   |
| nuclei             | Fast and customizable vulnerability scanner  |
| httpx              | Fast and multi-purpose HTTP scanner         |
| jre11-openjdk      | Java Runtime Environment 11                  |
| jdk11-openjdk      | Java Development Kit 11                      |



## How to build and run ?

```bash
# Change telegram configs in .env.example
mv .env.example .env
docker build -t blackcart .
docker run -it blackcart
docker run -it --env-file .env blackcart

```

## License

This project is licensed under the [MIT License](LICENSE).