$test = $MyInvocation.MyCommand.Definition
$test1 = $MyInvocation
$test2 = $MyInvocation.MyCommand

Write-Host $test
Write-Host $test1
Write-Host $test2
$args