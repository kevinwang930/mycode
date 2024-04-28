
 # Get the ID and security principal of the current user account
 $myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
 $myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
  
 # Get the security principal for the Administrator role
 $adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
  
 # Check to see if we are currently running "as Administrator"
 if ($myWindowsPrincipal.IsInRole($adminRole))
    {
        # add depot_tools path to system path variable
        $depotToolPath = "D:\tools\depot_tools"
        $systemPath = [Environment]::GetEnvironmentVariable('Path', 'Machine') -split ';' | Where-Object { $_ -notlike "*depot_tools*" } 

        $systemPath = $systemPath | Where-Object { -not [string]::IsNullOrEmpty($_) }       
        $newPath = (,$depotToolPath + $systemPath) -join ';'  #add element in front
        [Environment]::SetEnvironmentVariable("Path", $newPath, 'Machine')
    }
 else
    {

    $CommandLine = "-ExecutionPolicy ByPass -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments


    Start-Process -FilePath pwsh.exe  -Verb Runas -ArgumentList $CommandLine
    }