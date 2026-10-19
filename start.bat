@echo off
setlocal
cd /d "%~dp0"
call "%~dp0mvnw.cmd" -B package
if errorlevel 1 (
    echo Build failed. Check the messages above.
    pause
    exit /b 1
)
echo Open http://localhost:8080/
if defined APP_PORT echo Custom port: %APP_PORT%
echo Press Ctrl+C in this window to stop the application.
java -jar "%~dp0target\counselor.war"
if errorlevel 1 pause
