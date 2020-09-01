$publicip = (Invoke-WebRequest -uri "http://ifconfig.me/ip" -UseBasicParsing).Content

$lastpublicipdigit = $publicip.Substring($publicip.get_Length()-1)

$pass = "mOGu6nQn+"
$password = $pass+$lastpublicipdigit
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

$username1 = "BreachOdmin"
$username2 = "BreachA"
$username3 = "Breach2"
$username4 = "BreachX"
$username5 = "BreachBM"
$username6 = "BreachB2"
$username7 = "BreachSpecial"

New-LocalUser "$username5" -Password $securePassword -FullName "$username5" -Description "User 5" -PasswordNeverExpires
New-LocalUser "$username6" -Password $securePassword -FullName "$username6" -Description "User 6" -PasswordNeverExpires
New-LocalUser "$username7" -Password $securePassword -FullName "$username7" -Description "User 7" -PasswordNeverExpires

Add-LocalGroupMember -Group "Administrators" -Member "$username5"
Add-LocalGroupMember -Group "Administrators" -Member "$username6"
Add-LocalGroupMember -Group "Administrators" -Member "$username7"

Set-LocalUser -Name “$username1” -Password $securePassword -PasswordNeverExpires 1

Set-LocalUser -Name “$username2” -PasswordNeverExpires 1 -Description "User 2"
Set-LocalUser -Name “$username3” -PasswordNeverExpires 1 -Description "User 3"
Set-LocalUser -Name “$username4” -PasswordNeverExpires 1 -Description "User 4"

$credential1 = New-Object System.Management.Automation.PSCredential $username1, $securePassword
$credential2 = New-Object System.Management.Automation.PSCredential $username2, $securePassword
$credential3 = New-Object System.Management.Automation.PSCredential $username3, $securePassword
$credential4 = New-Object System.Management.Automation.PSCredential $username4, $securePassword
$credential5 = New-Object System.Management.Automation.PSCredential $username5, $securePassword
$credential6 = New-Object System.Management.Automation.PSCredential $username5, $securePassword
$credential7 = New-Object System.Management.Automation.PSCredential $username5, $securePassword

Start-Process powershell.exe -Credential $credential5 -WorkingDirectory 'C:\Windows\System32' exit
Start-Process powershell.exe -Credential $credential6 -WorkingDirectory 'C:\Windows\System32' exit
Start-Process powershell.exe -Credential $credential7 -WorkingDirectory 'C:\Windows\System32' exit


Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk" -Destination "$env:USERPROFILE\Desktop\Snipping Tool.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk" -Destination "C:\Users\$username2\Desktop\Snipping Tool.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk" -Destination "C:\Users\$username3\Desktop\Snipping Tool.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk" -Destination "C:\Users\$username4\Desktop\Snipping Tool.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk" -Destination "C:\Users\$username5\Desktop\Snipping Tool.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk" -Destination "C:\Users\$username6\Desktop\Snipping Tool.lnk"
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk" -Destination "C:\Users\$username7\Desktop\Snipping Tool.lnk"

