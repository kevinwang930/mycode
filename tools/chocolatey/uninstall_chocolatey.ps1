
 # Get the ID and security principal of the current user account
 $myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
 $myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
  
 # Get the security principal for the Administrator role
 $adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
  
 # Check to see if we are currently running "as Administrator"
 if ($myWindowsPrincipal.IsInRole($adminRole))
    {
      Remove-Item -Recurse -Force "$env:ChocolateyInstall" -WhatIf
      [System.Text.RegularExpressions.Regex]::Replace([Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment').GetValue('PATH', '', [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames).ToString(), [System.Text.RegularExpressions.Regex]::Escape("$env:ChocolateyInstall\bin") + '(?>;)?', '', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase) | % { [System.Environment]::SetEnvironmentVariable('PATH', $_, 'User') }
      [System.Text.RegularExpressions.Regex]::Replace([Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SYSTEM\CurrentControlSet\Control\Session Manager\Environment\').GetValue('PATH', '', [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames).ToString(), [System.Text.RegularExpressions.Regex]::Escape("$env:ChocolateyInstall\bin") + '(?>;)?', '', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase) | % { [System.Environment]::SetEnvironmentVariable('PATH', $_, 'Machine') }

      if ($env:ChocolateyBinRoot -ne '' -and $env:ChocolateyBinRoot -ne $null) { Remove-Item -Recurse -Force "$env:ChocolateyBinRoot" -WhatIf }
      if ($env:ChocolateyToolsRoot -ne '' -and $env:ChocolateyToolsRoot -ne $null) { Remove-Item -Recurse -Force "$env:ChocolateyToolsRoot" -WhatIf }
      [System.Environment]::SetEnvironmentVariable("ChocolateyBinRoot", $null, 'User')
      [System.Environment]::SetEnvironmentVariable("ChocolateyToolsLocation", $null, 'User')
    }
 else
    {

    $CommandLine = "-ExecutionPolicy ByPass -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments


    Start-Process -FilePath pwsh.exe  -Verb Runas -ArgumentList $CommandLine
    }
