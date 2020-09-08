Set-Location "$env:OneDriveCommercial\Containers\win10"

$gitDir = "$HOME/gitdir/Containers_win10.git"
git init --separate-git-dir=$gitDir

$relPath = (Resolve-Path -Relative $gitDir).Replace('\','/')
$writeText = "gitdir: $relPath"

$fileInfo = Get-Item -Force .git
$fileInfo.Attributes -= 'Hidden'

$writePath = (Resolve-Path .\.git).Path

$fileInfo, $writePath, $writeText
[IO.File]::WriteAllText($writePath, $writeText)

$fileInfo.Attributes += 'Hidden'

git status

# ======================

$a = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' | Select-Object CurrentMajorVersionNumber, CurrentMinorVersionNumber, CurrentBuildNumber, BaseBuildRevisionNumber
$WIN_VER = $a.PSObject.Properties.Value -join '.'
$WIN_VER = (cmd.exe /C VER | Select-String '[.\d]+').Matches.Value
$WIN_VER
$WIN_VER = '10.0.20206.1000'
# https://docs.microsoft.com/ja-jp/virtualization/windowscontainers/deploy-containers/gpu-acceleration
# https://docs.microsoft.com/ja-jp/virtualization/windowscontainers/manage-containers/persistent-storage#named-volumes
#docker run -v vol-ric:c:\data -it --isolation process --device class/5B45201D-F2F2-4F3B-85BB-30FF1F953599 mcr.microsoft.com/windows/servercore/insider:$WIN_VER powershell.exe
docker run -v "${env:OneDriveCommercial}\Containers\win10:c:\data" -it --isolation process --device class/5B45201D-F2F2-4F3B-85BB-30FF1F953599 mcr.microsoft.com/windows/servercore/insider:$WIN_VER powershell.exe -ExecutionPolicy Bypass -NoExit -File c:\data\profile.ps1

# -----

docker build . -t win10
docker images
docker history win10
#docker run -v "$env:OneDriveCommercial\Containers\win10:c:\data" -v "$HOME\Documents\installer:c:\installer:ro" -it --isolation process --device class/5B45201D-F2F2-4F3B-85BB-30FF1F953599 win10
docker run -v "$env:OneDriveCommercial\Containers\win10:c:\data" -v "$HOME\Documents\installer:c:\installer:ro" -it --isolation process --device class/5B45201D-F2F2-4F3B-85BB-30FF1F953599 win10 cmd

# -----

docker-compose down --rmi all --volumes
docker-compose ps -a
docker-compose images
docker ps -a
docker kill (docker ps -aq)
docker rm (docker ps -aq)
docker images -a
docker rmi (docker images -q)
docker volume ls
docker volume rm (docker volume ls -q)
docker network ls
