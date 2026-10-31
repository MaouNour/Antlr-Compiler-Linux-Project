#!/bin/bash
set -euo pipefail

ANTLR_VERSION="4.13.2"
ANTLR_JAR="/usr/local/lib/antlr-${ANTLR_VERSION}-complete.jar"
ANTLR_URL="https://www.antlr.org/download/antlr-${ANTLR_VERSION}-complete.jar"

echo "Installing Antlr4 Enviroment"
echo "----------------------------"

## 1 - JDK
echo "Installing OpenJDK 25 :"
echo "----------------------------"
sudo dnf install -y java-25-openjdk

## 2 - Antrl Jar
echo "Installing Antlr4 jar:"
echo "-----------------------------"
if [[ ! -f "$ANTLR_JAR" ]]; then
    tmp_file=$(mktemp)
    trap 'rm -f "$tmp_file"' EXIT

    curl -fL "$ANTLR_URL" -o "$tmp_file"
    sudo install -D -m 644 "$tmp_file" "$ANTLR_JAR"
else
    echo "ANTLR JAR already exists. Skipping download."
fi

## 3 - Configure Bash
if ! grep -qF '# ANTLR 4.13.2' ~/.bashrc; then
    cat >> ~/.bashrc <<'EOF'

# ANTLR 4.13.2
alias antlr4='java -jar /usr/local/lib/antlr-4.13.2-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
export CLASSPATH=".:/usr/local/lib/antlr-4.13.2-complete.jar"
EOF
else
    echo "ANTLR Bash configuration already exists. Skipping."
fi

echo "=== Installation complete ==="