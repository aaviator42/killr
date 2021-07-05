:: killr by @aaviator42
:: v1.0

:: Installation:
:: see https://github.com/aaviator42/killr

@echo off
REM CHANGE THESE:
set port=80
set comfile=killcommands.cmd 

REM CHANGE NOTHING ELSE:
set reqPrev=XXYYZZ89BLEH

echo ---
echo killr: listening now on port %port%
echo:
echo %date% %time% - Listening now on port %port% > killr_log.txt


:main
if exist pass.txt (
	set /p password=<pass.txt
	set "file=index1.html"
) else (
	set "password=%RANDOM%%RANDOM%"
	set "file=index2.html"
)

(type res.txt && type %file%) | nc -w 1 -l -p %port% | findstr "GET" > __par
set /p req=<__par

if "%req%" == "%reqPrev%" (
	goto :main 
)
if "%req%" == "GET /favicon.ico HTTP/1.1" (
	goto :main 
)

if "%req%" == "" (
	goto :main 
)

if "%req%" == "GET / HTTP/1.1" (
	goto :main 
)

echo.
:: echo -- New valid request recieved! --

set reqPrev=%req%
echo Request: %req%

set req2=%req: HTTP/1.1=%
set req2=%req2:GET /=%

:: echo Filtered request: %req2%

set input=%req2:~10%

echo Input: %input%

powershell -c "Add-Type -AN System.Web; [System.Web.HttpUtility]::UrlDecode('%input%')" > __input
set /p input2=<__input

:: echo Filtered Input: %input2%


if exist pass.txt (
	if "%input2%" == "%password%" (
		goto :active
	)
)

echo %date% %time% - Unsuccessful attempt: %input2% >> killr_log.txt
goto :main

:active
echo -- KILLSWITCH ACTIVATED --
echo @ %date% %time%
echo %date% %time% - Successful killswitch activation: %input2% >> killr_log.txt
del pass.txt
start %comfile%
goto :main