Set-PSReadLineOption -HistorySavePath C:\data\ConsoleHost_history.txt
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None

function q() { exit }

# function which ($arg) {
#     Get-Command "$arg" | Format-List
# }

Set-Alias -Name which -Value Get-Command
Set-Alias -Name touch -Value New-Item
