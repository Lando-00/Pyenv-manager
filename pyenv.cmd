@echo off

:: ---------------------
:: Main script logic
:: ---------------------

if "%~1"=="" goto usage

set "ENV_DIR=%Python_Env_Dir%"
set "command=%~1"
shift

:: Simple "switch"
if /I "%command%"=="list"     call :cmd_list & goto :EOF
if /I "%command%"=="activate" call :cmd_activate %* & goto :EOF
if /I "%command%"=="help"     call :cmd_help & goto :EOF
if /I "%command%"=="deactivate" call :cmd_deactivate %* & goto :EOF
if /I "%command%"=="delete"   call :cmd_delete %* & goto :EOF

:: Default
call :cmd_default
goto :EOF

:usage
echo Pyenv      -       Python virtual environment manager (v1.1)
echo created by -       Lovanto George
echo --- --- --- --- --- --- --- --- --- --- --- --- 
echo Type "pyenv help" for usage instructions.
echo Usage:
echo   pyenv list               -   List all Python environments
echo   pyenv activate ^<env^>   -   Activate a Python environment
echo   pyenv deactivate         -   Deactivate the current environment
echo   pyenv delete ^<env^>     -   Delete an environment
echo   pyenv help               -   Show this help message
goto :EOF


:: ---------------------
:: Subroutines below
:: ---------------------

:cmd_list
if not exist "%ENV_DIR%" (
    echo The specified environment directory does not exist: "%ENV_DIR%"
    exit /b 1
)
echo Listing Python virtual environments...
echo --- --- --- --- --- --- --- --- --- --- --- --- 
for /d %%D in ("%ENV_DIR%\*") do echo "%%~nxD"
echo --- --- --- --- --- --- --- --- --- --- --- --- 
exit /b 0

:cmd_activate
:: %1 is already "activate", so the first real argument is now %2
if "%~2"=="" (
    echo Please specify an environment name.
    echo Usage: pyenv activate ^<env_name^>
    exit /b 1
)
set "env_name=%~2"
set "ACTIVATE_SCRIPT=%ENV_DIR%\%env_name%\Scripts\activate.bat"
if not exist "%ACTIVATE_SCRIPT%" (
    echo Environment "%env_name%" not found or missing activation script.
    exit /b 1
)
echo Activating environment: "%env_name%"
call "%ACTIVATE_SCRIPT%"
set "env_active=%env_name%"
exit /b 0

:cmd_help
echo Usage:
echo   pyenv list            - List all Python environments
echo   pyenv activate ^<env^>  - Activate a Python environment
echo   pyenv deactivate      - Deactivate the current environment
echo   pyenv delete ^<env^>  - Delete an environment
echo   pyenv help            - Show this help message
exit /b 0

:cmd_deactivate
set "user_inputted_env=%~2"
set "TARGET_DIR=%ENV_DIR%\%user_inputted_env%\Scripts\deactivate.bat"
if not "%~2"=="" (
    echo User has specified an environment name!
    echo Pyenv will assume an environment was activated and will try to deactivate it.
    if not exist "%TARGET_DIR%" (
        echo Error: Environment "%user_inputted_env%" not found or missing deactivation script.
        exit /b 1
    )

    if "%env_active%"=="%user_inputted_env%" (
        echo Deactivating environment: "%user_inputted_env%"
        call "%TARGET_DIR%"
        set "env_active="
        exit /b 0
    ) else (
        echo Error: Environment "%user_inputted_env%" is not recorded by Pyenv as currently active.
        if "%env_active%"=="" (
            echo No environment was activated with Pyenv.
        ) else (
            echo Current Recorded Active environment is: "%env_active%"
        )
        echo --- --- --- --- --- --- --- --- --- --- --- --- 
        echo Pyenv will try to deactivate current environment with Path variables!
        echo Deactivating potentially active environment: "%VIRTUAL_ENV%"
        call "%VIRTUAL_ENV%/Scripts/deactivate.bat"
        set "env_active="
        exit /b 1
    )
)
if "%env_active%"=="" (
        echo Error: No environment was activated with Pyenv.
        exit /b 1
    )
echo Deactivating environment...
call "%ENV_DIR%\%env_active%\Scripts\deactivate.bat"
set "env_active="
exit /b 0

:cmd_delete
if "%~2"=="" (
    echo Please specify an environment name.
    echo Usage: pyenv delete ^<env_name^>
    exit /b 1
)
set "env_name=%~2"
:: Build a temporary variable, don't overwrite ENV_DIR
set "TARGET_DIR=%ENV_DIR%\%env_name%"
if not exist "%TARGET_DIR%" (
    echo Environment "%env_name%" not found.
    exit /b 1
)
echo Deleting environment "%env_name%"...
rmdir /s /q "%TARGET_DIR%"
exit /b 0

:cmd_default
echo Invalid command: "%command%"
echo Type "pyenv help" for usage instructions.
exit /b 1

:EOF
