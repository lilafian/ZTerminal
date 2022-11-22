:: ZTerminal
:: By Lilaf


@echo off
title ZTerminal
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"


set ztver=ztb-1
:start
echo ==ZTerminal==
echo.
cd %USERPROFILE%
:entcmd
set /p cmd=%time%^|%date%^|%cd%^> 

::Command List
if /I %cmd%==run goto run
if /I %cmd%==help goto help
if /I %cmd%==zt goto zt
if /I %cmd%==zterminal goto zt
if /I %cmd%==wincmd goto wincmd
if /I %cmd%==close goto close
if /I %cmd%==ver goto ver
if /I %cmd%==version goto ver
if /I %cmd%==cmdlist goto help
if /I %cmd%==cmds goto help
if /I %cmd%==ztfolder goto ztfolder
if /I %cmd%==createdir goto createdir
if /I %cmd%==cd goto cd
if /I %cmd%==whoami goto whoami
if /I %cmd%==winver goto winver
if /I %cmd%==removedir goto removedir
if /I %cmd%==createmultdir goto createmultdir
if /I %cmd%==opencd goto opencd
if /I %cmd%==echo goto echo
if /I %cmd%==viewcd goto opencd
if /I %cmd%==viewuser goto whoami
if /I %cmd%==newwindow goto zt
if /I %cmd%==devmode-1091 goto DEVMODE
if /I %cmd%==credits goto credits

::Invalid CMD
echo %cmd% is not a valid command.
goto entcmd

:run
echo Enter a program or URL.
set /p runans=
start %runans%
goto entcmd

:help
echo Enter a command to get help for, or type "help" again to see a list of all commands.
set /p helpcmd=
if %helpcmd%==help (
    echo Help menu, unfinished.
    goto entcmd
)

:zt
cls
goto start

:wincmd
cmd

:close
exit

:ver
echo Your current version of ZTerminal is:
echo %ztver%
goto entcmd 

:ztfolder
start %~dp0

:createdir
echo Enter a name for the directory.
set /p crdirn=
echo Any variables? (type "none" if no variables)
set /p crdirvar=
::CREATEDIR Variable List
if /I %crdirvar%==none goto crdir
if /I %crdirvar%==hidden goto crdirhd

:crdir
mkdir "%crdirn%"
goto entcmd

:crdirhd
mkdir %crdirn%
attrib +h %crdirn% /s /d
goto entcmd

:cd
echo Enter a directory to move to:
set /p chcd=
cd %chcd%
goto entcmd

:whoami
You are
whoami
goto entcmd

:winver
winver
goto entcmd

:removedir
echo Enter a directory to remove.
set /p rdans=
echo Are you sure you want to remove %rdans% and all of its subdirectories and files? (y/n)
set /p rdcon=
if /I %rdcon%==y (
    rd %rdans% /s /q
    echo Removed %rdans% and all subdirectories and files.
    goto entcmd
)
if /I %rdcon%==n (
    echo Cancelled.
    goto entcmd
)

:createmultdir
echo Enter the directory names, all wrapped in quotes. (Ex. "folder 1" "folder 2" "folder 3")
set /p crmdirns=
echo Any variables? (type "none" if no variables)
set /p crmdirvar=
if /I crmdirvar==none goto crmdir
if /I crmdirvar==hidden goto crmdirhd

:crmdir
mkdir %crmdirns%
goto entcmd

:crmdirhd
mkdir %crmdirns%
attrib +h %crmdirns% /s /q
goto entcmd

:opencd
start %cd%
goto entcmd

:echo
echo Say what back?
set /p echo=
echo %echo%
goto entcmd

:credits
cls 
echo -ZTERMINAL-
echo -By Strawberry Milk Software-
ping localhost -n 3 >nul
cls 
echo -ZTERMINAL-
echo -By Strawberry Milk Software-
echo Interface - Lilaf
ping localhost -n 3 >nul
cls 
echo -ZTERMINAL-
echo -By Strawberry Milk Software-
echo Interface - Lilaf
echo Commands - Lilaf
ping localhost -n 3 >nul
cls 
echo -ZTERMINAL-
echo -By Strawberry Milk Software-
echo Interface - Lilaf
echo Commands - Lilaf
echo Developer Commands - Lilaf
ping localhost -n 3 >nul
cls 
echo -ZTERMINAL-
echo -By Strawberry Milk Software-
echo Interface - Lilaf
echo Commands - Lilaf
echo Developer Commands - Lilaf
echo Thank you for using ZTerminal!
ping localhost -n 9 >nul
cls 
echo Thank you for using ZTerminal!
ping localhost -n 15 >nul
cls
goto start



:DEVMODE
echo Are you sure you want to enter Developer Mode? This could be dangerous. (y/n)
set /p dmcon=
if /I %dmcon%==y goto devmodeact
if /I %dmcon%==n goto entcmd

:devmodeact
echo Developer Mode activated.
:dmentcmd
set /p cmdDEV=DEV %cd%^>

if /I %cmdDEV%==exitdev goto exitdev
if /I %cmdDEV%==delzt goto delzt
if /I %cmdDEV%==cd goto devcd
if /I %cmdDEV%==qemu goto qemu

echo %cmdDEV% is not a valid developer command.
goto dmentcmd



:exitdev
goto entcmd

:delzt
echo WARNING: Running this command will delete the entire ZTerminal directory. Do you want to continue? (y/n)
set /p DELZTCON=  Are you sure? ^>
if /I %DELZTCON%==y goto ABSOLUTECON
if /I %DELZTCON%==n goto dmentcmd


:ABSOLUTECON
echo Are you ABSOLUTELY, positively sure you want to remove ZTerminal? (y/n)
set /p DELZTCON=  Are you sure? ^>
if /I %DELZTCON%==y goto deletezterminal
if /I %DELZTCON%==n goto dmentcmd

:deletezterminal
echo Deleting ZTerminal...
cd %~dp0
rd %cd%

:devcd
echo Enter a directory to move to:
set /p chcd=
cd %chcd%
goto dmentcmd

:qemu
cls
echo ==== ZTerminal QEMU Interface ====
echo Enter a file to run in QEMU:
set /p qemu=qemu-system-x86_64 
qemu-system-x86_64 %qemu%
goto entcmd