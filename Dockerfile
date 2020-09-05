# escape=`

# Installer image
FROM mcr.microsoft.com/windows/servercore/insider:10.0.20206.1000 AS installer

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY profile.ps1 C:\Users\ContainerAdministrator\Documents\WindowsPowerShell\profile.ps1

CMD [ "powershell.exe" ]
