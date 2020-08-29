Invoke-WebRequest https://fs.ankores.com.ua/s/TDcm3g58w4DDMai/download -OutFile c:\ReIcon.zip
Expand-Archive -Path C:\ReIcon.zip -DestinationPath "C:\Program Files\RDP Wrapper" -ErrorAction SilentlyContinue
Remove-Item C:\ReIcon.zip

#configure windows update
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name AUOptions -Value 4 -ErrorAction SilentlyContinue
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name ScheduledInstallDay -Value 1 -ErrorAction SilentlyContinue
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name ScheduledInstallTime -Value 3 -ErrorAction SilentlyContinue
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name AutoInstallMinorUpdates -Value 1 -ErrorAction SilentlyContinue
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name RebootWarningTimeoutEnabled -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name RebootRelaunchTimeoutEnabled -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name RescheduleWaitTimeEnabled -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name NoAutoUpdate -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" -Name AUOptions -Value 0 -ErrorAction SilentlyContinue
cmd.exe /c "UsoClient StartScan"
cmd.exe /c "UsoClient StartDownload"
cmd.exe /c "UsoClient StartInstall"

#start chkdsk after reboot and sfc/scannow in separate window
cmd.exe /c "echo y|chkdsk c: /f /r /x"
Start-Process cmd.exe -WorkingDirectory 'C:\Windows\System32' -ArgumentList "/c sfc /scannow" -WindowStyle Minimized



#get public ip
$publicip = (Invoke-WebRequest -uri "http://ifconfig.me/ip" -UseBasicParsing).Content

#get public ip last digit
$lastpublicipdigit = $publicip.Substring($publicip.get_Length()-1)

#set password
$pass = "mOGu6nQn+"
$password = $pass+$lastpublicipdigit
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

#set usernames
$username1 = "BreachA"
$username2 = "Breach2"
$username3 = "BreachX"

#logoff other users
$sessionID1 = ((quser | Where-Object {$_ -match 'breacha' }) -split ' +')[2]
$sessionID2 = ((quser | Where-Object {$_ -match 'breach2' }) -split ' +')[2]
$sessionID3 = ((quser | Where-Object {$_ -match 'breachx' }) -split ' +')[2]
If ($sessionID1)  {logoff $sessionID1}
If ($sessionID2)  {logoff $sessionID2}
If ($sessionID3)  {logoff $sessionID3}

#delete old users
cmd.exe /c "del c:\users\breacha /s /Q"
cmd.exe /c "del c:\users\breach2 /s /Q"
cmd.exe /c "del c:\users\breachx /s /Q"
cmd.exe /c "rmdir c:\users\breacha\ /s /Q"
cmd.exe /c "rmdir c:\users\breach2\ /s /Q"
cmd.exe /c "rmdir c:\users\breachx\ /s /Q"
cmd.exe /c "net user breacha /delete"
cmd.exe /c "net user breach2 /delete"
cmd.exe /c "net user breachx /delete"
cmd.exe /c "takeown /f "c:\users\breacha" /r /d y"
cmd.exe /c "takeown /f "c:\users\breach2" /r /d y"
cmd.exe /c "takeown /f "c:\users\breachx" /r /d y"
Remove-Item C:\Users\breacha -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item C:\Users\breach2 -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item C:\Users\breachx -Recurse -Force -ErrorAction SilentlyContinue

#create local users
New-LocalUser "$username1" -Password $securePassword -FullName "$username1" -Description "User 1"
New-LocalUser "$username2" -Password $securePassword -FullName "$username2" -Description "User 2"
New-LocalUser "$username3" -Password $securePassword -FullName "$username3" -Description "User 3"

#add users to administrator group
Add-LocalGroupMember -Group "Administrators" -Member "$username1"
Add-LocalGroupMember -Group "Administrators" -Member "$username2"
Add-LocalGroupMember -Group "Administrators" -Member "$username3"

#create user profiles but running powershell as user
$credential1 = New-Object System.Management.Automation.PSCredential $username1, $securePassword
$credential2 = New-Object System.Management.Automation.PSCredential $username2, $securePassword
$credential3 = New-Object System.Management.Automation.PSCredential $username3, $securePassword
Start-Process powershell.exe -Credential $credential1 -WorkingDirectory 'C:\Windows\System32' exit
Start-Process powershell.exe -Credential $credential2 -WorkingDirectory 'C:\Windows\System32' exit
Start-Process powershell.exe -Credential $credential3 -WorkingDirectory 'C:\Windows\System32' exit

#save desktop shortcuts placement 
cmd.exe /c "C:\Program Files\RDP Wrapper\ReIcon\ReIcon_x64.exe"
cmd.exe /c '"C:\Program Files\RDP Wrapper\ReIcon\ReIcon_x64.exe" /S /File "C:\Program Files\RDP Wrapper\ReIcon\"'

#replicate profile from admin profile
$sourceDirectory  = "$env:USERPROFILE"
$destinationDirectory1 = "C:\Users\BreachA\"
$destinationDirectory2 = "C:\Users\Breach2\"
Copy-item -Force -Recurse $sourceDirectory\Desktop -Destination $destinationDirectory1 -ErrorAction Continue -Verbose
Copy-item -Force -Recurse $sourceDirectory\Documents -Destination $destinationDirectory1 -ErrorAction Continue -Verbose
Copy-item -Force -Recurse $sourceDirectory\Downloads -Destination $destinationDirectory1 -ErrorAction Continue -Verbose
Copy-item -Force -Recurse $sourceDirectory\Desktop -Destination $destinationDirectory2 -ErrorAction Continue -Verbose
Copy-item -Force -Recurse $sourceDirectory\Documents -Destination $destinationDirectory2 -ErrorAction Continue -Verbose
Copy-item -Force -Recurse $sourceDirectory\Downloads -Destination $destinationDirectory2 -ErrorAction Continue -Verbose

#create startup bat file for icons placement
$batcode1 = @'
@echo of
cmd.exe /c ""C:\Program Files\RDP Wrapper\ReIcon\ReIcon_x64.exe" /R /File "C:\Program Files\RDP Wrapper\ReIcon\""
start "" "C:\Program Files\RDP Wrapper\ReIcon\ReIcon_x64.exe"
start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
timeout 5
taskkill /IM chrome.exe
del %0
'@
$batcode2 = @'
@echo of
logoff
del %0
'@
New-Item -Path "C:\Users\$username1\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Name "onetimestartupscript.bat" -ItemType File -Value $batcode1
New-Item -Path "C:\Users\$username2\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Name "onetimestartupscript.bat" -ItemType File -Value $batcode1
New-Item -Path "C:\Users\$username3\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Name "onetimestartupscript.bat" -ItemType File -Value $batcode2

#login to profile ro run startup script for shortcuts placement
New-Item -Path "HKCU:\Software\Microsoft\" -Name "Terminal Server Client" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKCU:\Software\Microsoft\Terminal Server Client" -Name "AuthenticationLevelOverride" -Value ”0”  -PropertyType "DWord" 
$serverip = $publicip+":33322"
cmdkey /generic:$publicip /user:$username1 /pass:$password
Start-Process mstsc.exe -ArgumentList "/v:$serverip" 
Start-Sleep -s 2
cmdkey /delete:$publicip
cmdkey /generic:$publicip /user:$username2 /pass:$password
Start-Process mstsc.exe -ArgumentList "/v:$serverip"
Start-Sleep -s 2
cmdkey /delete:$publicip
cmdkey /generic:$publicip /user:$username3 /pass:$password
Start-Process mstsc.exe -ArgumentList "/v:$serverip"
Start-Sleep -s 2
cmdkey /delete:$publicip
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Terminal Server Client" -Name "AuthenticationLevelOverride"

#replicate chrome data
$sourceDirectorychrome  = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\"
$destinationDirectorychrome1 = "C:\Users\BreachA\AppData\Local\Google\Chrome\User Data\"
$destinationDirectorychrome2 = "C:\Users\Breach2\AppData\Local\Google\Chrome\User Data\"
Copy-item -Force -Recurse $sourceDirectorychrome\Default -Destination $destinationDirectorychrome1 -ErrorAction Continue -Verbose
Copy-item -Force -Recurse "$sourceDirectorychrome\Profile *" -Destination $destinationDirectorychrome1 -ErrorAction Continue -Verbose
Copy-item -Force -Recurse $sourceDirectorychrome\Default -Destination $destinationDirectorychrome2 -ErrorAction Continue -Verbose
Copy-item -Force -Recurse "$sourceDirectorychrome\Profile *" -Destination $destinationDirectorychrome2 -ErrorAction Continue -Verbose



