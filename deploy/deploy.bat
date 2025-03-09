@echo off

flutter build web

for /f "tokens=*" %%a in ('git rev-parse --abbrev-ref HEAD') do set BRANCH=%%a

if "%BRANCH%"=="main" (
    echo Deploying to production channel
    firebase deploy
) else (
    echo Deploying to preview channel for branch: %BRANCH%
    firebase hosting:channel:deploy "%BRANCH%" --expires 7d
)