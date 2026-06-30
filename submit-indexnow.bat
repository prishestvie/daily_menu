@echo off
REM ============================================
REM  IndexNow URL Submission (Windows Batch)
REM  Usage: submit-indexnow.bat [url]
REM  Example: submit-indexnow.bat https://menunaden.ru/
REM ============================================

setlocal enabledelayedexpansion

set "KEY=4e9e1b79-f56b-4fee-abe7-a3ac4403a01a"
set "SITE=https://menunaden.ru"
set "ENDPOINT=https://yandex.com/indexnow"

if "%1"=="" (
    echo Submitting sitemap to IndexNow...
    powershell -Command "& { .\submit-indexnow.ps1 }"
) else (
    echo Submitting URL: %1
    powershell -Command "& { .\submit-indexnow.ps1 -Url '%1' }"
)

pause