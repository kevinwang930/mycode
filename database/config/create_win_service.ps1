
 # Get the ID and security principal of the current user account
 $myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
 $myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
  
 # Get the security principal for the Administrator role
 $adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
  
 # Check to see if we are currently running "as Administrator"
 if ($myWindowsPrincipal.IsInRole($adminRole))
    {
        Get-Service -Include mariadb* | Stop-Service
        Get-Service -Include mariadb* | remove-Service
        $filePath = Join-Path -Path $PSScriptRoot -ChildPath "mariadb_config.ini"
        mysqld --install mariaDB  --defaults-file=$filePath
        Get-Service -Include mariaDB | Start-Service
    }
 else
    {

    $CommandLine = "-ExecutionPolicy ByPass -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments


    Start-Process -FilePath pwsh.exe  -Verb Runas -ArgumentList $CommandLine
    }

 