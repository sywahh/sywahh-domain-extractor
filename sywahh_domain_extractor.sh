#!/bin/bash

# === Banner ===
if command -v figlet >/dev/null && command -v lolcat >/dev/null; then
  figlet "Sywahh Domains Extractor" | lolcat
else
  echo ">>> SYWAHH DOMAINS EXTRACTOR TOOL <<<"
fi

# === Validate Input ===
if [ $# -ne 1 ]; then
  echo "Usage: $0 <input_txt_or_csv_file>"
  exit 1
fi

INPUT="$1"

# Check for valid file type
if [[ ! "$INPUT" =~ \.(csv|txt)$ ]]; then
  echo "[!] Input must be a .csv or .txt file"
  exit 1
fi

if [ ! -f "$INPUT" ]; then
  echo "[!] File $INPUT not found."
  exit 1
fi

# === Output Filenames ===
OUTPUT_MAIN="main_domains.txt"
OUTPUT_SUB="subdomains.txt"
OUTPUT_IPV4="ipv4_addresses.txt"
OUTPUT_IPV6="ipv6_addresses.txt"

echo "[*] Processing file: $INPUT..."

# === Normalize Input: strip URLs, ports, www, paths, etc. ===
cat "$INPUT" | tr ',' '\n' | tr '[:upper:]' '[:lower:]' | \
sed -E -e 's#https?://##g' \
       -e 's#^www[0-9]*\.##g' \
       -e 's#/.*##g' \
       -e 's/:.*//g' | \
grep -v '^$' | sort -u > cleaned_targets.tmp

# === Extract IP Addresses ===
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' cleaned_targets.tmp | sort -u > "$OUTPUT_IPV4"
grep -Eoi '([a-f0-9]{1,4}:){1,7}[a-f0-9]{1,4}' cleaned_targets.tmp | sort -u > "$OUTPUT_IPV6"

# === Extract Domains ===
grep -Eo '([a-z0-9-]+\.)+[a-z]{2,}' cleaned_targets.tmp | grep -vE '^([0-9]{1,3}\.){3}[0-9]{1,3}$' | sort -u > all_domains.tmp

# === Extract Main Domains (like example.com) ===
awk -F. 'NF>=2 {print $(NF-1)"."$NF}' all_domains.tmp | sort -u > "$OUTPUT_MAIN"

# === Extract Subdomains (exclude main domains) ===
comm -23 all_domains.tmp "$OUTPUT_MAIN" > "$OUTPUT_SUB"

# === Cleanup Temp Files ===
rm -f cleaned_targets.tmp all_domains.tmp

# === Done ===
echo "[✓] Extraction Complete!"
echo "→ Main Domains:      $OUTPUT_MAIN"
echo "→ Subdomains:        $OUTPUT_SUB"
echo "→ IPv4 Addresses:    $OUTPUT_IPV4"
echo "→ IPv6 Addresses:    $OUTPUT_IPV6"
