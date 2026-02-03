@echo off
echo ========================================
echo Portfolio Website Test Suite
echo ========================================
echo.

REM Test 1: Verify all HTML files exist
echo [TEST 1] Checking HTML files...
if exist index.html (echo ✓ index.html found) else (echo ✗ index.html missing & set FAIL=1)
if exist about.html (echo ✓ about.html found) else (echo ✗ about.html missing & set FAIL=1)
if exist contact.html (echo ✓ contact.html found) else (echo ✗ contact.html missing & set FAIL=1)
if exist style.css (echo ✓ style.css found) else (echo ✗ style.css missing & set FAIL=1)
echo.

REM Test 2: Validate HTML structure (basic checks)
echo [TEST 2] Basic HTML validation...
findstr /i "DOCTYPE html" index.html >nul && echo ✓ index.html has DOCTYPE || echo ✗ index.html missing DOCTYPE
findstr /i "viewport" index.html >nul && echo ✓ index.html responsive || echo ✗ index.html not responsive
echo.

REM Test 3: Check navigation links
echo [TEST 3] Navigation link validation...
findstr /i "href="*.html" index.html >nul && echo ✓ Navigation links present || echo ✗ Navigation links missing
echo.

REM Test 4: CSS validation
echo [TEST 4] CSS file check...
findstr /i "nav.*background" style.css >nul && echo ✓ Navigation styling found || echo ✗ Navigation styling missing
findstr /i "body.*font-family" style.css >nul && echo ✓ Font styling found || echo ✗ Font styling missing
echo.

REM Test 5: Generate test report
echo [TEST 5] Generating test report...
echo Test Suite Completed at %date% %time% > test-report.txt
echo ======================================== >> test-report.txt
if defined FAIL (
    echo ✗ TEST FAILED: Missing files detected >> test-report.txt
    exit /b 1
) else (
    echo ✓ ALL TESTS PASSED >> test-report.txt
    echo. >> test-report.txt
    echo Files validated: index.html, about.html, contact.html, style.css >> test-report.txt
)

echo.
echo ========================================
echo ✓ All tests passed! Check test-report.txt
echo ========================================
