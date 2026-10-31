
@echo off
setlocal

set "ANTLR_VERSION=4.13.2"
set "ANTLR_JAR=%USERPROFILE%\antlr\antlr-%ANTLR_VERSION%-complete.jar"
set "ANTLR_URL=https://www.antlr.org/download/antlr-%ANTLR_VERSION%-complete.jar"

echo Installing ANTLR4 Environment
echo -----------------------------

:: 1 - Check Java
echo Checking Java installation...

where java >nul 2>&1
if errorlevel 1 (
    echo ERROR: Java was not found in PATH.
    echo Please install JDK 25 and try again.
    exit /b 1
)

java -version

:: 2 - Download ANTLR
echo.
echo Installing ANTLR %ANTLR_VERSION%...

if not exist "%ANTLR_JAR%" (
    if not exist "%USERPROFILE%\antlr" mkdir "%USERPROFILE%\antlr"

    curl -fL "%ANTLR_URL%" -o "%ANTLR_JAR%"

    if errorlevel 1 (
        echo ERROR: Failed to download ANTLR.
        exit /b 1
    )
) else (
    echo ANTLR JAR already exists. Skipping download.
)

:: 3 - Configure environment variables
echo.
echo Configuring environment variables...

set "ANTLR_HOME=%USERPROFILE%\antlr"
set "NEW_CLASSPATH=.;%ANTLR_JAR%"

setx ANTLR_HOME "%ANTLR_HOME%" >nul
setx CLASSPATH "%NEW_CLASSPATH%" >nul

:: 4 - Create helper commands
echo.
echo Creating ANTLR helper scripts...

set "BIN_DIR=%USERPROFILE%\antlr\bin"
if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"

(
    echo @echo off
    echo java -jar "%ANTLR_JAR%" %%*
) > "%BIN_DIR%\antlr4.bat"

(
    echo @echo off
    echo java -cp "%ANTLR_JAR%;%%CLASSPATH%%" org.antlr.v4.gui.TestRig %%*
) > "%BIN_DIR%\grun.bat"

:: Add helper directory to user PATH
powershell -NoProfile -Command ^
 "$p=[Environment]::GetEnvironmentVariable('Path','User');" ^
 "$d='%BIN_DIR%';" ^
 "if (($p -split ';') -notcontains $d) {" ^
 "[Environment]::SetEnvironmentVariable('Path',(($p.TrimEnd(';')+';'+$d).TrimStart(';')),'User') }"

echo.
echo -----------------------------
echo Installation completed!
echo.
echo ANTLR JAR: %ANTLR_JAR%
echo Helper commands: %BIN_DIR%
echo.
echo Restart your terminal to use:
echo   antlr4
echo   grun
echo.
echo VS Code may also need restarting.
echo -----------------------------

endlocal
