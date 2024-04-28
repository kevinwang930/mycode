
#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "D:\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion
# $Host.UI.RawUI.BackgroundColor = 'White'
# $Host.UI.RawUI.ForegroundColor = 'Black'
$Host.PrivateData.DebugForegroundColor = 'DarkYellow'
$host.privateData.WarningForegroundColor = "DarkYellow"
$host.privateData.VerboseForegroundColor = "Green"
Set-PSReadLineOption -Colors @{
    Command            = 'Magenta'
    Number             = 'DarkGray'
    Member             = 'DarkGray'
    Operator           = 'DarkGray'
    Type               = 'DarkGray'
    Variable           = 'DarkGreen'
    Parameter          = 'DarkGreen'
    ContinuationPrompt = 'DarkGray'
    Default            = 'DarkGray'
}
