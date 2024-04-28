 # remove depot_tools path from system path variable
        $depotToolPath = "D:\tools\depot_tools"
        $systemPath = [Environment]::GetEnvironmentVariable('Path', 'Machine') -split ';' | Where-Object { $_ -notlike "*depot_tools*" -and -not [string]::IsNullOrEmpty($_)} 

      #   $systemPath = $systemPath | Where-Object { -not [string]::IsNullOrEmpty($_) }       
        $newPath = $systemPath -join ';'  #add element in front
        write-host $newPath
        $folder = (get-item $MyInvocation.MyCommand.path).Directory
        write-host $folder
      #   [Environment]::SetEnvironmentVariable("Path", $newPath, 'Machine')

      #   # add another system variable
      #   $targetValue = 0
      #   $targetVariable = "DEPOT_TOOLS_WIN_TOOLCHAIN"
      #   [Environment]::SetEnvironmentVariable($targetVariable, $targetValue, 'Machine')
