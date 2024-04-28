
 # Get the ID and security principal of the current user account
 $myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
 $myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
  
 # Get the security principal for the Administrator role
 $adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
  
 # Check to see if we are currently running "as Administrator"
 if ($myWindowsPrincipal.IsInRole($adminRole))
    {
         $folder = (get-item $MyInvocation.MyCommand.path).Directory
         $stdout = Join-Path  $folder "stdout.txt"
        # remove depot_tools path from system path variable
        $depotToolPath = "D:\tools\depot_tools"
        $systemPath = [Environment]::GetEnvironmentVariable('Path', 'Machine') -split ';' | Where-Object { $_ -notlike "*depot_tools*" -and -not [string]::IsNullOrEmpty($_)} 

      #   $systemPath = $systemPath | Where-Object { -not [string]::IsNullOrEmpty($_) }       
        $newPath = $systemPath -join ';'  #add element in front
        write-host $newPath *>>$stdout
        [Environment]::SetEnvironmentVariable("Path", $newPath, 'Machine') 

        # add another system variable
        $targetValue = 0
        $targetVariable = "DEPOT_TOOLS_WIN_TOOLCHAIN"
        [Environment]::SetEnvironmentVariable($targetVariable, $null, 'Machine')
    }
 else
    {
      $folder = (get-item $MyInvocation.MyCommand.path).Directory
      $stdout = Join-Path  $folder "stdout.txt"
      $CommandLine = "-ExecutionPolicy ByPass -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments 
      Start-Process -FilePath pwsh.exe  -Verb Runas -ArgumentList $CommandLine 
    }