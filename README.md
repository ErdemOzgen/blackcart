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

# Continuous Automated Red Teaming

Continuous automated red teaming (CART) is an advanced cybersecurity approach that incorporates automation and continuous testing into traditional red team exercises. Unlike manual red teaming conducted annually or bi-annually, CART ensures ongoing security testing throughout the year. By continuously testing an organization's cybersecurity defenses, CART aims to detect and address vulnerabilities proactively, preventing attackers from exploiting them. This method provides a more proactive and comprehensive approach to enhancing an organization's security posture. Blackcart is a streamlined Dockerfile that comprises a collection of essential security tools suitable for Continuous Automated Red Teaming (CART).

## Installed Tools


| Tool            | Description                                       |
| --------------- | ------------------------------------------------- |
| git             | Distributed version control system               |
| python          | General-purpose programming language             |
| python-pip      | Package installer for Python packages            |
| go              | Programming language for system-level development|
| nmap            | Network exploration and security auditing tool   |
| rustscan        | Fast network scanner                              |
| zmap            | Network scanner for Internet-wide surveys        |
| amass           | In-depth subdomain enumeration tool              |
| gau             | Fetch URLs from Google web search                |
| traceroute      | Traceroute networking utility                     |
| sslscan         | SSL/TLS vulnerability scanner                     |
| massdns         | High-performance DNS server                       |
| altdns          | Subdomain permutation generation tool            |
| httprobe        | Take a list of domains and probe HTTP/HTTPS      |
| masscan         | Fast TCP port scanner                             |
| hosthunter      | OSINT tool for discovering hostnames             |
| zaproxy         | Web application security scanner (OWASP ZAP)     |
| gobuster        | Directory/file and DNS busting tool              |
| dirsearch       | Web path scanner and brute-forcer                |
| hydra           | Password-cracking tool                            |
| gospider        | Web spidering and intelligent scraping tool      |
| xsstrike        | Advanced XSS detection suite                      |
| ssrf-sheriff    | Server-Side Request Forgery (SSRF) detection tool|
| ssrfmap         | Automatic SSRF fuzzer and exploitation tool      |
| corscanner      | Cross-Origin Resource Sharing (CORS) scanner     |
| crlfuzz         | Carriage Return Line Feed (CRLF) injection tool  |
| assetfinder     | Subdomain enumeration tool                        |
| orunmila        | Security testing and reconnaissance tool         |
| cspparse        | CSP (Content Security Policy) parser             |
| certnames       | Extract SSL/TLS certificate names from a list    |
| sniprobe        | Probe endpoints to check for server side request forgery vulnerability|
| harx            | Extract and manipulate HTTP Archive (HAR) files  |
| subfinder       | Subdomain discovery tool                          |
| notify          | Cloud-native notification service                |
| nuclei          | Powerful vulnerability scanner for dynamic application security testing (DAST)|
| httpx           | Fast and multi-purpose HTTP toolkit              |

## License

This project is licensed under the [MIT License](LICENSE).