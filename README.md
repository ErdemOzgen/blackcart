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
    <a href="https://www.codefactor.io/repository/github/erdemozgen/blackcart/overview/main"><img src="https://www.codefactor.io/repository/github/erdemozgen/blackcart/badge/main" alt="CodeFactor" /></a>
  </p>

# Docker Container for Continuous Automated Red Teaming and DevSecOps Pipelines

Continuous automated red teaming (CART) is an advanced cybersecurity approach that incorporates automation and continuous testing into traditional red team exercises. Unlike manual red teaming conducted annually or bi-annually, CART ensures ongoing security testing throughout the year. By continuously testing an organization's cybersecurity defenses, CART aims to detect and address vulnerabilities proactively, preventing attackers from exploiting them. This method provides a more proactive and comprehensive approach to enhancing an organization's security posture. Blackcart is a streamlined Dockerfile that comprises a collection of essential security tools suitable for Continuous Automated Red Teaming (CART).

# Blackcart: Empowering DevSecOps Pipelines

Blackcart, originally designed for Continuous Automated Red Teaming (CART), extends its capabilities to serve as a valuable asset in the world of DevSecOps. DevSecOps integrates security practices into the software development and delivery lifecycle, fostering a culture of security-first development.

## DevSecOps with Blackcart

Blackcart's rich arsenal of security tools and its containerized environment make it an ideal candidate for DevSecOps pipelines. Here's how Blackcart can contribute to your DevSecOps practices:

### 1. Continuous Security Testing

Blackcart enables continuous security testing of your applications and infrastructure. Incorporate it into your CI/CD pipelines to automatically scan for vulnerabilities, misconfigurations, and potential threats, ensuring that security remains a top priority throughout the development process.

### 2. Vulnerability Assessment

Utilize Blackcart's extensive toolkit to perform vulnerability assessments on your code, dependencies, and infrastructure components. Identify and remediate vulnerabilities early in the development cycle, reducing the risk of security breaches.

### 3. Threat Detection

Leverage Blackcart's security tools to detect and analyze threats in real-time. Monitor for suspicious activities and potential security incidents, allowing for immediate response and mitigation.

### 4. Automation and Orchestration

Integrate Blackcart into your automation and orchestration workflows. Automate security scans, tests, and compliance checks, enabling rapid feedback and ensuring that security is an integral part of your development and deployment processes.

### 5. Compliance and Reporting

Generate comprehensive security reports and compliance documentation using Blackcart's tools. Streamline the auditing process and demonstrate compliance with industry standards and regulations.

Incorporating Blackcart into your DevSecOps pipelines enhances your organization's ability to build and deploy secure applications while fostering a proactive security culture. It's not just about Continuous Automated Red Teaming; it's about empowering DevSecOps practices for a more secure digital future.

## Installed Tools


| Name               | Description                                  |
| ------------------ | -------------------------------------------- |
| git                | Version control system                       |
| python             | Programming language                         |
| python-pip         | Python package manager                       |
| go                 | Programming language                         |
| nmap               | Network exploration tool                     |
| nuclei             | Fast and customizable vulnerability scanner  |
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
| httpx              | Fast and multi-purpose HTTP scanner         |
| jre11-openjdk      | Java Runtime Environment 11                  |
| jdk11-openjdk      | Java Development Kit 11                      |
| Shodan             | Internet-wide network scanning tool           |
| Censys             | Internet-wide network scanning tool           |
| Go-dork       | he fastest dork scanner written in Go. including Google, Shodan, Bing, Duck, Yahoo and Ask.                     |
| Gitleaks           | Tool for finding sensitive information in Git repositories |
| Favicon            | Extracts favicon URLs from websites crosssearch with shodan          |
| WaybackURLs        | Tool to discover archived web pages          |
| XSS Striker        | XSS scanner                                  |
| IIS Shortname Scanner | Scanner for IIS short filename disclosure |
| JSLeak             | JavaScript link finder tool                  |
| Smuggler           | HTTP request smuggling scanner               |
| [WebAnalyzer](https://github.com/ErdemOzgen/WAP_API)        | Website analysis tool                        |
| wapiti             | Comprehensive web app vulnerability scanner written in Python |




## How to build and run ?

```bash
# Change telegram configs in .env.example
mv .env.example .env
docker buildx build -t blackcart .
docker run -it blackcart
docker run -it --env-file .env blackcart

```

## License

This project is licensed under the [MIT License](LICENSE).
