#!/bin/bash
set -euo pipefail

ANTLR_VERSION="4.13.2"
ANTLR_JAR="/usr/local/lib/antlr-${ANTLR_VERSION}-complete.jar"
ANTLR_URL="https://www.antlr.org/download/antlr-${ANTLR_VERSION}-complete.jar"

echo "Installing Antlr4 Enviroment"
echo "----------------------------"

## 1 - Install Java JDK 25
echo "Installing OpenJDK 25:"
echo "----------------------------"

if command -v dnf &>/dev/null; then
    sudo dnf install -y java-25-openjdk

elif command -v apt-get &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y openjdk-25-jdk

elif command -v pacman &>/dev/null; then
    sudo pacman -S --needed jdk25-openjdk

elif command -v zypper &>/dev/null; then
    sudo zypper install -y java-25-openjdk

elif command -v apk &>/dev/null; then
    sudo apk add openjdk25

else
    echo "Unsupported package manager."
    echo "Please install OpenJDK 25 manually."
    exit 1
fi

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
export ANTLR_HOME="/usr/local/lib"
EOF
else
    echo "ANTLR Bash configuration already exists. Skipping."
fi

echo "=== Installation complete ==="