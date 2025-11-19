Write-Host "---------------LOOPING DNS RESOLVE TOOL--------------" -ForegroundColor Green
$error.clear()
#clears error cache
Write-host 'INPUT DELAY BETWEEN LOOPS IN SECONDS (eg. 10)' -ForegroundColor Yellow
$sleep = Read-Host -Prompt 'Delay'
#asks user for input
Write-host 'INPUT DESTINATION SERVER (eg. google.com)' -ForegroundColor Yellow
$server = Read-Host -Prompt 'Destination server'
#asks user for another input
Write-host 'INPUT RESOLVE SERVER (eg. 8.8.8.8); If left empty, default will be used. Please separate multiple resolve servers with comma.' -ForegroundColor Yellow
$resolve = Read-Host -Prompt 'Resolve server'
#asks user for yet another input
$resolvearray = ($resolve.Split(",")).Trim()
#makes array of user input to $resolve variable, trims spaces
while ($true) {  
#loop starts here
    Write-Host "----------------------LOOKUP STARTING-----------------------" -ForegroundColor Green
    $resolvearray|ForEach-Object{Resolve-DnsName -Name $server -server $_ -ErrorAction SilentlyContinue; write-host "RESOLVE SERVER USED:" $_; write-host $Error[0] -BackgroundColor Red; $error.clear(); write-host "`n"}
    #loop resolvedns for each row in $resolvearray, write last row from error log and clears it after each loop
    Write-host "---------------NEXT LOOKUP IN $sleep SECONDS----------------" -ForegroundColor Green
    start-sleep -seconds $sleep
    #wait for amount of time defined in $sleep
}


