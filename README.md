# sywahh-domain-extractor
This tool will extract Main Domains, Sub-domains, IPv4 and IPv6 from a given text file or .CSV file.

# Sywahh Domains Extractor 🕵️‍♂️

A colorful, lightweight Bash tool to extract:

- ✅ Main Domains (e.g., `example.com`)
- ✅ Subdomains (e.g., `api.example.com`)
- ✅ IPv4 Addresses (e.g., `192.168.1.1`)
- ✅ IPv6 Addresses (e.g., `2606:4700:4700::1111`)

Supports `.csv` or `.txt` files — perfect for bug bounty, recon, and automation.

---

## ✨ Features

- Removes junk like `http://`, `https://`, `www`, ports, and paths
- Outputs clean `.txt` files
- Works great with tools like `httpx`, `dnsx`, `amass`, `nmap`
- Rainbow banner with `figlet` + `lolcat` (optional!)

---

## 🚀 Usage

### 1️⃣ Install dependencies (optional for banner)
```bash
sudo apt install figlet
sudo gem install lolcat

**## How to Install**
01) Download the script in your local machine
02) create a directory and move the script to that directory
03) To execute the script - give the permission as **chmod +x extractdomains.sh**

**RUN the SCRIPT**
./extractdomains.sh targets.csv
# or
./extractdomains.sh targets.txt

**You will have OUTPUT as**
Output Files
main_domains.txt
subdomains.txt
ipv4_addresses.txt
ipv6_addresses.txt

**🔥 Example Input**
https://www.example.com
api.dev.example.com
192.168.0.1
https://test.example.org:8080/path

**Outputs:**
main_domains.txt: example.com, example.org
subdomains.txt: api.dev.example.com, test.example.org
ipv4_addresses.txt: 192.168.0.1

main_domains.txt: example.com, example.org

subdomains.txt: api.dev.example.com, test.example.org

ipv4_addresses.txt: 192.168.0.1

**🧑‍💻 Author
Made with ❤️ by Shiva aka sywahh
If you find this useful, star ⭐ the repo and share it with the infosec community!
**


