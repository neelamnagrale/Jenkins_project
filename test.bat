@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Portfolio Website Test Suite
echo ========================================

set FAIL=0

echo.
echo [TEST 1] Checking required files...
if exist index.html (
    echo ✓ index.html found
) else (
    echo ✗ index.html missing
    set FAIL=1
)

if exist about.html (
    echo ✓ about.html found
) else (
    echo ✗ about.html missing
    set FAIL=1
)

if exist contact.html (
    echo ✓ contact.html found
) else (
    echo ✗ contact.html missing
    set FAIL=1
)

if exist style.css (
    echo ✓ style.css found
) else (
    echo ✗ style.css missing
    set FAIL=1
)

echo.
echo [TEST 2] Basic HTML validation...
findstr /i "<!DOCTYPE html>" index.html >nul
if errorlevel 1 (
    echo ✗ DOCTYPE missing
    set FAIL=1
) else (
    echo ✓ DOCTYPE present
)

echo.
echo [TEST 3] CSS validation...
findstr /i "font" style.css >nul
if errorlevel 1 (
    echo ✗ Font styling missing
    set FAIL=1
) else (
    echo ✓ Font styling found
)

echo.
echo [TEST 4] Writing report...
if not exist test-results mkdir test-results

if %FAIL%==0 (
    echo ALL TESTS PASSED > test-report.txt
    echo ✓ All tests passed!
    exit /b 0
) else (
    echo TESTS FAILED > test-report.txt
    echo ✗ Some tests failed
    exit /b 1
)
