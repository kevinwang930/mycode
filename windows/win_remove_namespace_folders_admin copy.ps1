 # Get the ID and security principal of the current user account
 $myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
 $myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
  
 # Get the security principal for the Administrator role
 $adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
  
 # Check to see if we are currently running "as Administrator"
 if ($myWindowsPrincipal.IsInRole($adminRole))
    {
       
       # remove 3d object
      Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{ 0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse
      Remove-Item  -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse
      New-Item -Path "HKCU:\Software\Classes\CLSID\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
      Set-ItemProperty -Path  "HKCU:\Software\Classes\CLSID\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Name "System.IsPinnedToNameSpaceTree" -Value 0 -Type DWord
      New-Item -Path "HKCU:\Software\Classes\WOW6432Node\CLSID\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
      Set-ItemProperty -Path  "HKCU:\Software\Classes\WOW6432Node\CLSID\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Name "System.IsPinnedToNameSpaceTree" -Value 0 -Type DWord
    }
 else
    {

    $CommandLine = "-ExecutionPolicy ByPass -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments


    Start-Process -FilePath pwsh.exe  -Verb Runas -ArgumentList $CommandLine
    }