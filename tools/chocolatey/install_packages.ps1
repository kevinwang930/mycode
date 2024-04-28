
# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
  
# Get the security principal for the Administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  
# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole)) {
        
    choco install packages.config
}
else {

    $CommandLine = "-ExecutionPolicy ByPass -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments


    Start-Process -FilePath pwsh.exe  -Verb Runas -ArgumentList $CommandLine
}
