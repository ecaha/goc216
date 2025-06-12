
#######################################################################################
##                                                                                   ##



$myName = 'Kamil'
$myName.GetType()

$hisAge = 37
$myName.GetType().FullName


$processes = Get-Process svchost
# returns an array, meaning you can index its members
$processes.GetType().FullName
$processes[2]


$severalSecondsAgo = [DateTime]::Now
$severalSecondsAgo.GetType().FullName


$myBirthday = Get-Date '1979-09-29'
$myBirthday.GetType().FullName




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##



# terminology - class: System.String, instance: $hisName
[string] $hisName = 'Martin'

# this [int] class alias is actually [System.Int32]
[int] $myGrandmaAge = 93

# values will have to be cast to the bound type
$myGrandmaAge = 93.75
$myGrandmaAge

# which would fail if the cast is not possible
$myGrandmaAge = 'she is nearly 100'




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##



$severalSecAgo = Get-Date
$severalSecAgo.GetType().FullName


$processes = Get-Process svchost
# returns an array, meaning you can index its members
$processes.GetType().FullName
$processes[3]
# and every member has a type of itself
$processes[3].GetType().FullName


$chaoticArray = @('Praha', 9, 'Bratislava', 77.4, 'Brno')
$chaoticArray.GetType().FullName
$chaoticArray[0].GetType().FullName
$chaoticArray[3].GetType().FullName



##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




$mUsers = Get-ADUser -Filter 'SamAccountName -like "m*"'
$mUsers.GetType().FullName
$mUsers[0]
$mUsers[1].GetType().FullName


$volumes = Get-CimInstance -Query 'SELECT * FROM Win32_LogicalDisk'
$volumes
$volumes.GetType().FullName
$volumes[0].GetType().FullName




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




# EXE commands produce array of strings
$ipConfigOut = ipconfig /all
$ipConfigOut.GetType().FullName
$ipConfigOut[4].GetType().FullName


# you can also bind the type to the variable
[string[]] $netstatOut = netstat -ano
$netstatOut.GetType().FullName




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




[string] $hisName = 'Martin'
Get-Member -Input $hisName
$hisName.Length
$hisName.ToUpper()


[int] $myGrandmaAge = 88
Get-Member -Input $myGrandmaAge
# some nonsense :-)
$myGrandmaAge.ToChar(([Globalization.CultureInfo]::InvariantCulture))


[double] $interest = 5.7183597
Get-Member -Input $interest
$interest.ToString('N2')





##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




$someValues = @('Praha', 9, 'Bratislava', 77.4, 'Brno')
Get-Member -In $someValues
$someValue.Count


$netlogonSvc = Get-Service netlogon
$netlogonSvc | fl *
Get-Member -i $netlogonSvc

$netlogonSvc.ProcessId # property
$netlogonSvc.Stop() # method

# you can reference properties that do not exist
$netlogonSvc.NonExisting

# but you cannot call methods that do not exit
$netlogonSvc.RestartMe()



##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




Start-Process notepad; Start-Process notepad
[object[]] $ntpds = Get-Process notepad
$ntpds.Count

Get-Member -In $ntpds[0]
$ntpds[0].CPU
$ntpds[0].Kill()





##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




# the -Filter parameter value is just a string value "accidentally" similar to the PowerShell filter syntax but processed by Active Directory Web Services internally
$mUsers = Get-ADUser -Filter 'SamAccountName -like "m*"'
$mUsers.GetType().FullName
$mUsers.Count
Get-Member -In $mUsers[0]


# uses WinRM connection over WMI queries
$volumes = Get-CimInstance -Query 'SELECT * FROM Win32_LogicalDisk'
$volumes.Count
Get-Member -I $volumes[0]


# accesses WMI directly but does not work in PowerShell Core
$volumesWMI = Get-WmiObject -Query 'SELECT * FROM Win32_LogicalDisk'
$volumesWMI.Count
Get-Member -I $volumesWMI[0]




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




$someTime = Get-Date
Get-Member -In $someTime

$someTime.Year
$sometime.DayOfWeek
$sometime.DayOfYear

$someTime.AddDays(17)
$someTime.AddHours(-90)
$someTime.IsDaylighSavingTime()
$sometime.ToUniversalTime()




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




$someDllFile = Get-Item c:\windows\system32\kernel32.dll
# using alias gm instead of the Get-Member cmdlet itself
gm -i $someDllFile

$someDllFile.FullName
$someDllFile.LastWriteTime

$someDllFile.LastWriteTime.ToUniversalTime()


# types may have custom operators defined
$someDllFile.LastWriteTime -gt (Get-Date 2014-05-21)



##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




$nothingInVariable = $null

# failure, nothing to work with
gm -i $nothingInVariable

# failure, cannot call a method on nothing
$nothingInVariable.GetType().FullName

# but you can ask for a property value even if the property does not exist in a bound/cast variable (return $null again)
$nothingInVariable.SomeProperty



##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##



$notBoundVariable = $null
$notBoundVariable.GetType().FullName


# if you bind the [string] type to a variable then PowerShell converts $null to an empty [string]
[string] $boundString = $null
$boundString.GetType().FullName
$boundString.Length


# if you bind the [int] type to a variable then PowerShell converts $null to zero
[int] $boundNumber = $null
$boundNumber.GetType().FullName
$boundNumber




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




$procArray = Get-Process svchost
$procArray.GetType().FullName


$singleProc = Get-Process lsass
$singleProc.GetType().FullName


# we have to use -ErrorAction SilentlyContinue parameter (in its alias form to keep it as short as possible)
$nothingFound = Get-Process nonexistent -EA Silent
$nothingFound.GetType().FullName




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




Start-Process mspaint
Get-Process mspaint | Stop-Process

Stop-Service netlogon; Start-Service netlogon

# while some other methods return values
[Diagnostics.Process]::Start('mspaint')




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




$noPing = ping nothingToPing
$noPing
$noPing.GetType().FullName


$pingOk = ping 10.10.0.11
$pingOk
$pingOk.GetType().FullName




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




[object[]] $singleProc = Get-Process lsass
$singleProc.GetType().FullName
$singleProc.Count


[object[]] $services = Get-Service p*
$services.GetType().FullName
$services.Count


[object[]] $noPing = ping nothingToPing
$noPing.GetType().FullName
$noPing.Count


[object[]] $nslookup = nslookup 10.10.0.11
$nslookup.GetType().FullName
$nslookup.Count



##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




$netlogon = Get-Service netlogon
$netlogon | fl Name, Status, StartType


# not a [string], but [System.ServiceProcess.ServiceControllerStatus] enum
# stopped = 1; running = 4; ...
$netlogon.Status.GetType().FullName
[int] $netlogon.Status
$netlogon.Status -eq 4


# [System.ServiceProcess.ServiceStartMode] enumeration
# boot = 0; system = 1; auto = 2; manual = 3; disabled = 4
$netlogon.StartType.GetType().FullName
$netlogon.StartType -ne 4





##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




$severalProcesses = Get-Process
# the type of the variable itself
gm -i $severalProcesses
# unique types of the array members piped one-by-one to the cmdlet (in this case only the [Diagnostics.Process])
$severalProcesses | Get-Member


$filesAndFolders = Get-ChildItem c:\windows\system32
# the type of the array variable itself
Get-Member -i $filesAndFolders
# two different types of objects inside the array ([IO.FileInfo] and [IO.DirectoryInfo])
$filesAndFolders | gm



##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




[object[]] $comps = Get-ADComputer -Filter 'name -like "w*"'

$comps.Count
$comps | Measure-Object

gm -i $comps[0]

$comps | gm




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




Get-Process svchost | Measure-Object

# Format-Table does not produce textual output on its own. It only generates formatting objects that go into pipe in a standard way and are displayed only at its end
Get-Process svchost | Format-Table | Measure-Object

Get-Process svchost | Format-Table | gm




##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




$wmiOS = Get-WmiObject Win32_OperatingSystem
$wmiOS | gm

$wmiOS.InstallDate
$wmiOS.InstallDate.GetType().FullName

$osDate = $wmiOS.ConvertToDateTime($wmiOS.InstallDate)
$osDate.GetType().FullName

(Get-Date) - $osDate





##                                                                                   ##
#######################################################################################
#######################################################################################
##                                                                                   ##




[string] 58.9

[xml] (Get-Content C:\TEMP\Training\mailparams.xml)

[guid] '0b3f6155-71eb-4cf5-a73a-dd291900ac50'

[ADSI] 'LDAP://CN=Tana,OU=People,OU=Company,DC=gopas,DC=virtual'




# cannot just cast - probably security
[ScriptBlock]::Create('Write-Host Hello; ipconfig; Get-Process')




##                                                                                   ##
#######################################################################################




# SIG # Begin signature block
# MIIVSQYJKoZIhvcNAQcCoIIVOjCCFTYCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDsOfMDN0566Hv6
# vyqPdy1u1mhLskWOJQ9+RJVXz0gu4qCCED8wggT+MIID5qADAgECAhANQkrgvjqI
# /2BAIc4UAPDdMA0GCSqGSIb3DQEBCwUAMHIxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xMTAvBgNV
# BAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBUaW1lc3RhbXBpbmcgQ0EwHhcN
# MjEwMTAxMDAwMDAwWhcNMzEwMTA2MDAwMDAwWjBIMQswCQYDVQQGEwJVUzEXMBUG
# A1UEChMORGlnaUNlcnQsIEluYy4xIDAeBgNVBAMTF0RpZ2lDZXJ0IFRpbWVzdGFt
# cCAyMDIxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwuZhhGfFivUN
# CKRFymNrUdc6EUK9CnV1TZS0DFC1JhD+HchvkWsMlucaXEjvROW/m2HNFZFiWrj/
# ZwucY/02aoH6KfjdK3CF3gIY83htvH35x20JPb5qdofpir34hF0edsnkxnZ2OlPR
# 0dNaNo/Go+EvGzq3YdZz7E5tM4p8XUUtS7FQ5kE6N1aG3JMjjfdQJehk5t3Tjy9X
# tYcg6w6OLNUj2vRNeEbjA4MxKUpcDDGKSoyIxfcwWvkUrxVfbENJCf0mI1P2jWPo
# GqtbsR0wwptpgrTb/FZUvB+hh6u+elsKIC9LCcmVp42y+tZji06lchzun3oBc/gZ
# 1v4NSYS9AQIDAQABo4IBuDCCAbQwDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQC
# MAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwQQYDVR0gBDowODA2BglghkgBhv1s
# BwEwKTAnBggrBgEFBQcCARYbaHR0cDovL3d3dy5kaWdpY2VydC5jb20vQ1BTMB8G
# A1UdIwQYMBaAFPS24SAd/imu0uRhpbKiJbLIFzVuMB0GA1UdDgQWBBQ2RIaOpLqw
# Zr68KC0dRDbd42p6vDBxBgNVHR8EajBoMDKgMKAuhixodHRwOi8vY3JsMy5kaWdp
# Y2VydC5jb20vc2hhMi1hc3N1cmVkLXRzLmNybDAyoDCgLoYsaHR0cDovL2NybDQu
# ZGlnaWNlcnQuY29tL3NoYTItYXNzdXJlZC10cy5jcmwwgYUGCCsGAQUFBwEBBHkw
# dzAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tME8GCCsGAQUF
# BzAChkNodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRTSEEyQXNz
# dXJlZElEVGltZXN0YW1waW5nQ0EuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBIHNy1
# 6ZojvOca5yAOjmdG/UJyUXQKI0ejq5LSJcRwWb4UoOUngaVNFBUZB3nw0QTDhtk7
# vf5EAmZN7WmkD/a4cM9i6PVRSnh5Nnont/PnUp+Tp+1DnnvntN1BIon7h6JGA078
# 9P63ZHdjXyNSaYOC+hpT7ZDMjaEXcw3082U5cEvznNZ6e9oMvD0y0BvL9WH8dQgA
# dryBDvjA4VzPxBFy5xtkSdgimnUVQvUtMjiB2vRgorq0Uvtc4GEkJU+y38kpqHND
# Udq9Y9YfW5v3LhtPEx33Sg1xfpe39D+E68Hjo0mh+s6nv1bPull2YYlffqe0jmd4
# +TaY4cso2luHpoovMIIFMTCCBBmgAwIBAgIQCqEl1tYyG35B5AXaNpfCFTANBgkq
# hkiG9w0BAQsFADBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5j
# MRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBB
# c3N1cmVkIElEIFJvb3QgQ0EwHhcNMTYwMTA3MTIwMDAwWhcNMzEwMTA3MTIwMDAw
# WjByMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQL
# ExB3d3cuZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3Vy
# ZWQgSUQgVGltZXN0YW1waW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
# CgKCAQEAvdAy7kvNj3/dqbqCmcU5VChXtiNKxA4HRTNREH3Q+X1NaH7ntqD0jbOI
# 5Je/YyGQmL8TvFfTw+F+CNZqFAA49y4eO+7MpvYyWf5fZT/gm+vjRkcGGlV+Cyd+
# wKL1oODeIj8O/36V+/OjuiI+GKwR5PCZA207hXwJ0+5dyJoLVOOoCXFr4M8iEA91
# z3FyTgqt30A6XLdR4aF5FMZNJCMwXbzsPGBqrC8HzP3w6kfZiFBe/WZuVmEnKYmE
# UeaC50ZQ/ZQqLKfkdT66mA+Ef58xFNat1fJky3seBdCEGXIX8RcG7z3N1k3vBkL9
# olMqT4UdxB08r8/arBD13ays6Vb/kwIDAQABo4IBzjCCAcowHQYDVR0OBBYEFPS2
# 4SAd/imu0uRhpbKiJbLIFzVuMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6enIZ3z
# bcgPMBIGA1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgGGMBMGA1UdJQQM
# MAoGCCsGAQUFBwMIMHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDov
# L29jc3AuZGlnaWNlcnQuY29tMEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5k
# aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3J0MIGBBgNVHR8E
# ejB4MDqgOKA2hjRodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
# cmVkSURSb290Q0EuY3JsMDqgOKA2hjRodHRwOi8vY3JsMy5kaWdpY2VydC5jb20v
# RGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMFAGA1UdIARJMEcwOAYKYIZIAYb9
# bAACBDAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdpY2VydC5jb20vQ1BT
# MAsGCWCGSAGG/WwHATANBgkqhkiG9w0BAQsFAAOCAQEAcZUS6VGHVmnN793afKpj
# erN4zwY3QITvS4S/ys8DAv3Fp8MOIEIsr3fzKx8MIVoqtwU0HWqumfgnoma/Capg
# 33akOpMP+LLR2HwZYuhegiUexLoceywh4tZbLBQ1QwRostt1AuByx5jWPGTlH0gQ
# GF+JOGFNYkYkh2OMkVIsrymJ5Xgf1gsUpYDXEkdws3XVk4WTfraSZ/tTYYmo9WuW
# wPRYaQ18yAGxuSh1t5ljhSKMYcp5lH5Z/IwP42+1ASa2bKXuh1Eh5Fhgm7oMLStt
# osR+u8QlK0cCCHxJrhO24XxCQijGGFbPQTS2Zl22dHv1VjMiLyI2skuiSpXY9aaO
# UjCCBgQwggPsoAMCAQICCiochHAAAQAAAH8wDQYJKoZIhvcNAQELBQAwbDELMAkG
# A1UEBhMCQ1oxFzAVBgNVBAgTDkN6ZWNoIFJlcHVibGljMQ0wCwYDVQQHEwRCcm5v
# MRAwDgYDVQQKEwdTZXZlY2VrMSMwIQYDVQQDExpTZXZlY2VrIEVudGVycHJpc2Ug
# Um9vdCBDQTAeFw0xOTA2MTExOTIzMzJaFw0yNDA2MDkxOTIzMzJaMIGPMQswCQYD
# VQQGEwJDWjEXMBUGA1UECBMOQ3plY2ggUmVwdWJsaWMxDTALBgNVBAcTBEJybm8x
# HDAaBgNVBAoTE0luZy4gT25kcmVqIFNldmVjZWsxFzAVBgNVBAMTDk9uZHJlaiBT
# ZXZlY2VrMSEwHwYJKoZIhvcNAQkBFhJvbmRyZWpAc2V2ZWNlay5jb20wggEiMA0G
# CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCeSNY2QrgV9RQ3yIA33WvL7CxKfxwU
# olsydE4CpOvHy3cffXmnb9tQbYOiwIU527RZxpM4t2bmhuFP7/c7sGql1yeVYqVI
# TPgAv3NB4Jt7j7405sFU8Fs8TXqP0LjEQuhdb9OLzoLY8SQ3lrMZS/EbHNBDjmDf
# Y6wQj4GHTmocySTehDovw7QWl3lbh74vge4pLck6KQ2GGvJM08P2CsX/TBdPOf3h
# OsvUaiG5oI+HyD0c60ygMJ34TGepXyriTrQPfsE4rUjzWFgUgGfwy8KyMxELlMrz
# sy0jtpRQh697mSilzxmnE22LcX/4+6HhRTEvecqN8AzocTRvsWqR+RGnAgMBAAGj
# ggGCMIIBfjATBgNVHSUEDDAKBggrBgEFBQcDAzAOBgNVHQ8BAf8EBAMCBsAwGwYJ
# KwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQU4ps2SSICG3YbEIhI
# kwnEuDiA4L0wHQYDVR0RBBYwFIESb25kcmVqQHNldmVjZWsuY29tMB8GA1UdIwQY
# MBaAFA2cyDJ91SLyX1R+K2FLgVDzxWzAMFIGA1UdHwRLMEkwR6BFoEOGQWh0dHA6
# Ly9wa2kuc2V2ZWNlay5jb20vQ0EvU2V2ZWNlayUyMEVudGVycHJpc2UlMjBSb290
# JTIwQ0EoMSkuY3JsMIGGBggrBgEFBQcBAQR6MHgwTQYIKwYBBQUHMAKGQWh0dHA6
# Ly9wa2kuc2V2ZWNlay5jb20vQ0EvU2V2ZWNlayUyMEVudGVycHJpc2UlMjBSb290
# JTIwQ0EoMSkuY3J0MCcGCCsGAQUFBzABhhtodHRwOi8vcGtpLnNldmVjZWsuY29t
# L29jc3AwDQYJKoZIhvcNAQELBQADggIBAJ+vpcO2387w4Gv5fmXj1QEtomuNRceQ
# Aeh90LunsEsJcizgZgi2LWV/qlqznIFDjbxoohMhOr+8QdRPKKLIq3NWRp8gtZdc
# o/HL7Oaa7D2h0Hcd5rgQI2lxobxQ23O8ybUOvRmuQQ2Fy/oje02FGvYA4T0Ao5+d
# US6WUUP+Zmp+Zo2SGmeXfWOTs4xJRByhjyoPoENA/3fvULXSAk6annuwd89rhWfk
# Tho3Ofz6j0L0cjuc1qBkXkFqYo4V1Ha6LsreSsxtO4Mej5lwD2cefNmqJUqkQEW7
# yUa/0x/4YNv3LHPoSNXfFLZFyfLBfa/PRVS3Y0aejwu52udamCtHLhKXvHoXBVUq
# 1L+jvMVIiIeCe0goW/y6tIpJO6QIsUpj18EgMOVYVXVlXUM2k1bGd7FYhG/YAfti
# XMpAIDhHKyfTWFV4EaxYWQKv0nfcuZV6dBimT16hgw9HABiDjyvrnA447Mu+bItI
# aWUfzwEy+ZND2bJerCno0MfWmyWNdOU9Rul/vDohnCxjR2EaE/2LKptysZ0rQGd/
# xlrpB2PeJe3B3VWClq0VmvE4zkprAIumRiXUAG6lvM2lbOYL6d/KarBtiIKiA+3W
# 8c7IXgQnvcTFUMKpeSmI28VGqa7V5pkg51s8J2XTRr2uTnY0qqj8FSzDXpMqwMRh
# MD/sAJsSycRHMYIEYDCCBFwCAQEwejBsMQswCQYDVQQGEwJDWjEXMBUGA1UECBMO
# Q3plY2ggUmVwdWJsaWMxDTALBgNVBAcTBEJybm8xEDAOBgNVBAoTB1NldmVjZWsx
# IzAhBgNVBAMTGlNldmVjZWsgRW50ZXJwcmlzZSBSb290IENBAgoqHIRwAAEAAAB/
# MA0GCWCGSAFlAwQCAQUAoIGEMBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJ
# KoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQB
# gjcCARUwLwYJKoZIhvcNAQkEMSIEIIOTbbbSBIgqt6XrweVzLATbUKgnV+6K2hCA
# 0mZ4wFinMA0GCSqGSIb3DQEBAQUABIIBAGjkYk534ZjDYw7UotM0Csfqm5fVbl6U
# NmuftnhPGRoYd53Yf9fEztmb5yBT0Px3KjYIMGWuJXe9oc/WbNxVf7xLvYEQcLdf
# k8iAoI9QtHOEvQxjKVPB4SHSXtKBy/UAtCGfb1dWjm6C5FMN13MOMuYX7iryuisQ
# SzFRNcl1GmKlC/3cKvuwH7ZFHpXRbYfTe93tVwbpbGBmRuFYwfLwU/i494HAbvQ5
# KB7P3IFryZ0dWu8NhKUg7sRUmuTYYeNWo3K74qjVK1ZoUKd9bpdgYqj0GDwjz2rz
# Z/icHfNL0a+cXA6Uf4H6WLXgBwTe9jB/CXcxPrIUGNYynsk2ZotGUWehggIwMIIC
# LAYJKoZIhvcNAQkGMYICHTCCAhkCAQEwgYYwcjELMAkGA1UEBhMCVVMxFTATBgNV
# BAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTExMC8G
# A1UEAxMoRGlnaUNlcnQgU0hBMiBBc3N1cmVkIElEIFRpbWVzdGFtcGluZyBDQQIQ
# DUJK4L46iP9gQCHOFADw3TANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzEL
# BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDIwMTA5NTUzMlowLwYJKoZI
# hvcNAQkEMSIEIIq8jIIy+B0OECYkFJWQH6esgwZWyVhcByt03xK8JU7CMA0GCSqG
# SIb3DQEBAQUABIIBABqNq2aLA1rtnoK7/hAihTNWZ0PXedSbKoY/KPETOSaboa9Y
# 6l9RjNb2pSEaQlnClwWeEwV4OyW0r9wk1adePrVbBVWOuq7TfPAFN2btaMrncwd+
# Jv55tnxSirG1mr0ytFNw4K6NBFSCZv/EUqTHn1X2pb4nRaQs4CUsdKxKV6g5jRiw
# sYCdbY1JFQHsvvJLqCEXp1ZNPSQlw04EvjtSbdDsyyi3EviZBFHqzJfzOewL+3s+
# yhkOEMA8qJ5mDdMMrpKCBiP1yA3RrLBWU1hwPFfWRQwh5dGkeDDqS7nPS+BKIjeg
# hgDwS8RxdiC7lKk5u3LzPXoOc6Q1VAMt4uiNd8w=
# SIG # End signature block
