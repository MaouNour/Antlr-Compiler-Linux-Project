
# ANTLR4 Development Environment

A cross-platform ANTLR4 development environment for Java projects using ANTLR 4.13.2.

Supports:
- Fedora and other major Linux distributions
- Windows
- Visual Studio Code

## Requirements

- Java JDK 25
- ANTLR 4.13.2
- Visual Studio Code
- Java Extension Pack
- ANTLR4 grammar support extension

## 1. Installation

### Linux

Run the installation script:

```bash
chmod +x install.sh
./install.sh
```

The script:

1. Installs OpenJDK 25 using the available package manager.
2. Downloads ANTLR 4.13.2.
3. Installs the ANTLR JAR at:

   `/usr/local/lib/antlr-4.13.2-complete.jar`

4. Adds ANTLR commands and CLASSPATH to `~/.bashrc`.

Reload Bash:

```bash
source ~/.bashrc
```

### Windows

First, install Java JDK 25 manually and make sure Java is available in PATH.

Then run:

```batch
install.bat
```

The script:

1. Downloads ANTLR 4.13.2.
2. Installs it under `%USERPROFILE%\antlr`.
3. Configures ANTLR_HOME and CLASSPATH.
4. Creates `antlr4` and `grun` helper commands.
5. Adds the helper directory to the user PATH.

Restart your terminal and VS Code after installation.

## 2. VS Code Setup

Install the following extensions:

- Java Extension Pack
- ANTLR4 grammar support

The project includes local VS Code configurations in `.vscode/`.

### Configure the ANTLR JAR

Open `.vscode/settings.json`.

For Linux:

```json
"java.project.referencedLibraries": [
    "/usr/local/lib/antlr-4.13.2-complete.jar"
]
```

For Windows:

```json
"java.project.referencedLibraries": [
    "C:/Users/YOUR_USERNAME/antlr/antlr-4.13.2-complete.jar"
]
```

Replace `YOUR_USERNAME` with your Windows username.

The source paths should include:

```json
"java.project.sourcePaths": [
    "src",
    "generated"
]
```

No global VS Code settings are required.

## 3. Generating Java Files from Grammar

ANTLR grammar files use the `.g4` extension.

To generate Java files:

1. Open the desired `.g4` grammar file.
2. Press `Ctrl + Shift + B`.
3. Select `ANTLR: Generate Java` if prompted.

Generated Java files will be placed inside:

```text
generated/
```

Repeat this whenever you modify a grammar.

## 4. Running the Java Program

Open `Main.java` and use the VS Code Run button or Run and Debug panel.

The Java project recognizes:

- `src/` - Main Java source files.
- `generated/` - ANTLR-generated Java files.
- ANTLR runtime JAR - Required runtime library.

## 5. Useful Commands

### Generate Java files manually

Linux and Windows (after configuring ANTLR):

```bash
antlr4 -Dlanguage=Java -o generated grammar/MyLexer.g4
```

### Compile Java files

Linux:

```bash
javac -cp ".:/usr/local/lib/antlr-4.13.2-complete.jar" \
    -d bin src/*.java generated/*.java
```

Windows:

```batch
javac -cp ".;%USERPROFILE%\antlr\antlr-4.13.2-complete.jar" -d bin src\*.java generated\*.java
```

### Run the program

Linux:

```bash
java -cp "bin:/usr/local/lib/antlr-4.13.2-complete.jar" Main
```

Windows:

```batch
java -cp "bin;%USERPROFILE%\antlr\antlr-4.13.2-complete.jar" Main
```

### Check Java

```bash
java -version
```

### Run ANTLR

```bash
antlr4
```

## 6. Project Structure

```text
project/
├── .vscode/
│   ├── settings.json
│   ├── launch.json
│   └── tasks.json
│
├── grammar/
│   └── MyLexer.g4
│
├── generated/
│   └── MyLexer.java
│
├── src/
│   └── Main.java
│
├── input/
│   └── input.js
│
├── install.sh
├── install.bat
├── .gitignore
└── README.md
```

## 7. Git

Generated files are build artifacts.

The `.g4` grammar files are the source of truth and should be committed to Git.

Generated Java files, compiled classes, and temporary ANTLR extension files should generally be ignored.

---

**ANTLR Version:** 4.13.2  
**Java Version:** 25
