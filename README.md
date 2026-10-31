
# ANTLR4 Java Development Environment

A simple ANTLR4 development environment using Java 25 and ANTLR 4.13.2 on Fedora Linux, integrated with Visual Studio Code.

## Requirements

- Fedora Linux
- Java JDK 25
- ANTLR 4.13.2
- Visual Studio Code
- Extension: Java Extension Pack
- Extension: ANTLR4 grammar support

## 1. Installation

Clone or download this project, then execute the installation script:

```bash
chmod +x install.sh
./install.sh
```

The script performs the following:

1. Installs OpenJDK 25 using DNF.
2. Downloads ANTLR 4.13.2.
3. Installs the ANTLR JAR at:

   `/usr/local/lib/antlr-4.13.2-complete.jar`

4. Configures the following commands in `~/.bashrc`:

| Command | Description |
|---------|-------------|
| `antlr4` | Runs the ANTLR tool |
| `grun` | Runs ANTLR TestRig |
| `CLASSPATH` | Makes ANTLR runtime classes available to Java |

After installation, reload Bash:

```bash
source ~/.bashrc
```

## 2. VS Code Setup

Install the required extensions:

- Java Extension Pack
- ANTLR4 grammar support

The project already contains local VS Code configurations under `.vscode/`.

The Java configuration includes the ANTLR JAR as a referenced library, so generated Java files can access the ANTLR runtime.

No global VS Code settings are required.

## 3. Generating Java Files from Grammar

ANTLR grammar files use the `.g4` extension.

To generate Java files:

1. Open the desired `.g4` grammar file.
2. Press `Ctrl + Shift + B`.
3. Select `ANTLR: Generate Java` if prompted.

ANTLR will generate the corresponding Java files inside:

```text
generated/
```

You can repeat this whenever you modify a grammar.

## 4. Running the Java Program

Open `Main.java` and use the VS Code Run button or the Run and Debug panel.

The Java project is configured to recognize:

- `src/` - Main Java source files.
- `generated/` - ANTLR generated Java files.
- ANTLR runtime JAR - Required library.

## 5. Project Structure

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
├── .gitignore
└── README.md
```

## 6. Useful Commands

Generate Java files manually:

```bash
antlr4 -Dlanguage=Java -o generated grammar/MyLexer.g4
```

Compile Java files:

```bash
javac -cp ".:/usr/local/lib/antlr-4.13.2-complete.jar" \
    -d bin src/*.java generated/*.java
```

Run the program:

```bash
java -cp "bin:/usr/local/lib/antlr-4.13.2-complete.jar" Main
```

Check Java installation:

```bash
java -version
```

Check ANTLR:

```bash
antlr4
```

---

**Note:** Generated Java files are build artifacts. The `.g4` grammar files are the source of truth and should be committed to Git.