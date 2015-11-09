sqlcmd /S LILO\SQLEXPRESS /d test2 -E -i"Step1CreateTables.sql"

for %%G in (Step2*.sql) do start sqlcmd /S LILO\SQLEXPRESS /d test2 -E -i"%%G"
echo --------------Wait till PHANTOM INSERT transations complete----------------
:WAITLOOP
tasklist /FI "IMAGENAME eq sqlcmd.exe" 2>NUL | find /I /N "sqlcmd.exe">NUL
if "%ERRORLEVEL%"=="0" goto RUNNING
goto NOTRUNNING

:RUNNING
ping 127.0.0.1
goto WAITLOOP

:NOTRUNNING
echo its over


for %%G in (Step3*.sql) do start sqlcmd /S LILO\SQLEXPRESS /d test2 -E -i"%%G"
echo --------------Wait till UNREPEATABLE READ transations complete----------------
:WAITLOOP1
tasklist /FI "IMAGENAME eq sqlcmd.exe" 2>NUL | find /I /N "sqlcmd.exe">NUL
if "%ERRORLEVEL%"=="0" goto RUNNING1
goto NOTRUNNING1

:RUNNING1
ping 127.0.0.1
goto WAITLOOP1

:NOTRUNNING1
echo its over

for %%G in (Step4*.sql) do start sqlcmd /S LILO\SQLEXPRESS /d test2 -E -i"%%G"
echo --------------Wait till DIRTY READ transations complete----------------
:WAITLOOP2
tasklist /FI "IMAGENAME eq sqlcmd.exe" 2>NUL | find /I /N "sqlcmd.exe">NUL
if "%ERRORLEVEL%"=="0" goto RUNNING2
goto NOTRUNNING2

:RUNNING2
ping 127.0.0.1
goto WAITLOOP2

:NOTRUNNING2
echo its over

for %%G in (Step5*.sql) do start sqlcmd /S LILO\SQLEXPRESS /d test2 -E -i"%%G"
echo --------------Wait till LOST UPDATE transations complete----------------
:WAITLOOP3
tasklist /FI "IMAGENAME eq sqlcmd.exe" 2>NUL | find /I /N "sqlcmd.exe">NUL
if "%ERRORLEVEL%"=="0" goto RUNNING3
goto NOTRUNNING3

:RUNNING3
ping 127.0.0.1
goto WAITLOOP3

:NOTRUNNING3
echo its over

sqlcmd /S LILO\SQLEXPRESS /d test2 -E -i"StepLastDetectIsolationLevel.sql"
echo --------------Removing added databases----------------

sqlcmd /S LILO\SQLEXPRESS /d test2 -E -i"StepLastLastDropTables.sql"
pause