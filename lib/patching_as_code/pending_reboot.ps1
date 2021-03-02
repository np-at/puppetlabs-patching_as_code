function Get-PendingReboot {
    #Copied from http://ilovepowershell.com/2015/09/10/how-to-check-if-a-server-needs-a-reboot/
    #Adapted from https://gist.github.com/altrive/5329377
    #Based on <http://gallery.technet.microsoft.com/scriptcenter/Get-PendingReboot-Query-bdb79542>

    $rebootPending = $false

    if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA Ignore) { $rebootPending = $true }
    if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) { $rebootPending = $true }
    if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA Ignore) { $rebootPending = $true }
    try {
        $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
        $status = $util.DetermineIfRebootPending()
        if (($null -ne $status) -and $status.RebootPending) {
            $rebootPending = $true
        }
    }
    catch { }

    # return result
    $rebootPending
}

Get-PendingRebo
# SIG # Begin signature block
# MIINLwYJKoZIhvcNAQcCoIINIDCCDRwCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUSBcvgYKe5BewTmS/Vwh8hWrk
# TsugggqVMIIEQDCCAyigAwIBAgITRgAAAAMMEMk5N0eWSAAAAAAAAzANBgkqhkiG
# 9w0BAQsFADAcMRowGAYDVQQDExFPRkZMSU5FLVJPT1RDQS1DQTAeFw0xODA1MjMy
# MjU2NDFaFw0yODA1MjMxOTQ3MTNaMEwxEzARBgoJkiaJk/IsZAEZFgNvcmcxFjAU
# BgoJkiaJk/IsZAEZFgZjZm9yYXQxHTAbBgNVBAMTFGNmb3JhdC1DQS1PTlNJVEUx
# LUNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzh5GriegdM0UvTyi
# d1FDOT5BGyMHRcyExCjFT6TfgDUhPC2IkItIMxHeCrKH9Vm0M49ZuP+sRZcTAwFB
# WMz1QvVMgEJhYoPZ+9/Ns6YncBdMwK7TRTdojH9Y2XIhGADVN9fSQhkkpB/0gfXY
# ZdTQE7t1Dj5BB/J78/081txv6DMPINFUSXtZJVo9iQDWeSSQfneC9sJFbP/IwgwS
# v/Qgn3fEYkdAhOzKK8G0KgONAxHhyaJrBWuqqfxKm07ACd1IZDziazybhp3tOF2l
# vI3B2enWshevjvdBlSUG6kojXtvCKb8Wk/LAiBZ86HvRR/6FCc0ynkn7NawYew1J
# G9eujwIDAQABo4IBSTCCAUUwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFDIC
# G2rarYRPgJknJ7jjFyvlEryUMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsG
# A1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFOSTj/f/7d4O
# PERLEwdPI1gce1JiME4GA1UdHwRHMEUwQ6BBoD+GPWh0dHA6Ly9DQS1vbnNpdGUx
# LmNmb3JhdC5vcmcvQ2VydEVucm9sbC9PRkZMSU5FLVJPT1RDQS1DQS5jcmwwaAYI
# KwYBBQUHAQEEXDBaMFgGCCsGAQUFBzAChkxodHRwOi8vQ0Etb25zaXRlMS5jZm9y
# YXQub3JnL0NlcnRFbnJvbGwvb2ZmbGluZS1yb290Q0FfT0ZGTElORS1ST09UQ0Et
# Q0EuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQA8VbB5iCHO3kMjqzQwaxMT1OwmG/JV
# fAZ/bDy5QKoVKUCukRxoxPBqjgy5zT394vA85PV5phCV9SYQU/S1qNK2YAW1N/B+
# hZailzLsL1bxPCaMfxztRlCYj9R3UDsAb0H3cQ2OA6un0I8iJHkeWhnBgBJDyyzf
# BRdmjkY31V0xSoaI5L/U0t7bMXmG7JUqHEtWee+qAepuHHbSJ1IbfYizxTWuf/6v
# pOr1fSeX2dKEf5DIIFtRFWLwlTlhE1TvfFQLCul815PcnPsMCLs9HyKGw7a+56vu
# ttfkyROA6/OoBTMZgZcwEEPdn7fqYJmSRMGR9KBsCqkfOCdtjdVgIHULMIIGTTCC
# BTWgAwIBAgITMQAACfHYqF4b87ZlCgAAAAAJ8TANBgkqhkiG9w0BAQsFADBMMRMw
# EQYKCZImiZPyLGQBGRYDb3JnMRYwFAYKCZImiZPyLGQBGRYGY2ZvcmF0MR0wGwYD
# VQQDExRjZm9yYXQtQ0EtT05TSVRFMS1DQTAeFw0yMTAzMDIwNTUzMTRaFw0yMjAz
# MDIwNTUzMTRaMGYxEzARBgoJkiaJk/IsZAEZFgNvcmcxFjAUBgoJkiaJk/IsZAEZ
# FgZjZm9yYXQxDzANBgNVBAsTBkNmb3JBVDEOMAwGA1UECxMFU3RhZmYxFjAUBgNV
# BAMTDU5vYWggUHJhc2tpbnMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQC6BKrhrou7HAytD7M7w9lpn6PDs6fnilqMAFJg5VKGlSuyPZXSmKnZM2dGOrHI
# DDtqc2X5NutvgjxuW3e73DniyBGNfbOcZAhgh/0lkKDrJHigjJzrXmqhI7F3nLZg
# Bz5dJ2VOPwRsHt7euOX6D+HWVyJkxiYCOybya6o4g3hMnH6SWCUmEDbdSmWUKc3P
# K9AIAmPqGfZfEYBf7HoRsphRqKa/vbVQTutQ6dwHiUFFBuPmxnGX512mw7WyZ9gA
# S8JTvqTRv1NAmcYRVwTXHOFaFg6ggFue0TTg6axDMPGAftBtYgarngDCb0M7IhX4
# urbwETBWuHlXij0If5J0xOwJAgMBAAGjggMMMIIDCDA9BgkrBgEEAYI3FQcEMDAu
# BiYrBgEEAYI3FQiFz/cfh5bnCoSphRGB3t9Wg5aeKE2B7vU4gr/zZwIBZAIBAzAT
# BgNVHSUEDDAKBggrBgEFBQcDAzAOBgNVHQ8BAf8EBAMCB4AwGwYJKwYBBAGCNxUK
# BA4wDDAKBggrBgEFBQcDAzAvBgNVHREEKDAmoCQGCisGAQQBgjcUAgOgFgwUbnBy
# YXNraW5zQGNmb3JhdC5vcmcwHQYDVR0OBBYEFPII1BrxWkrIq/AoYPzUAzfU0Kr/
# MB8GA1UdIwQYMBaAFDICG2rarYRPgJknJ7jjFyvlEryUMIIBGwYDVR0fBIIBEjCC
# AQ4wggEKoIIBBqCCAQKGgb1sZGFwOi8vL0NOPWNmb3JhdC1DQS1PTlNJVEUxLUNB
# LENOPUNBLW9uc2l0ZTEsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2Vz
# LENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Y2ZvcmF0LERDPW9yZz9j
# ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlz
# dHJpYnV0aW9uUG9pbnSGQGh0dHA6Ly9DQS1vbnNpdGUxLmNmb3JhdC5vcmcvQ2Vy
# dEVucm9sbC9jZm9yYXQtQ0EtT05TSVRFMS1DQS5jcmwwgfQGCCsGAQUFBwEBBIHn
# MIHkMIGyBggrBgEFBQcwAoaBpWxkYXA6Ly8vQ049Y2ZvcmF0LUNBLU9OU0lURTEt
# Q0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2Vz
# LENOPUNvbmZpZ3VyYXRpb24sREM9Y2ZvcmF0LERDPW9yZz9jQUNlcnRpZmljYXRl
# P2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTAtBggrBgEF
# BQcwAYYhaHR0cDovL0NBLW9uc2l0ZTEuY2ZvcmF0Lm9yZy9vY3NwMA0GCSqGSIb3
# DQEBCwUAA4IBAQB1QH9LwYmH4ABV2VQIec+zmZaJUyHl9YAhbvGu+1Z+aclcLQgY
# y2DFwsqyUKtQPdy7xb8/y3kiaWEJ6meHn9OexVbzq7yRYMcD28KW/zEndXVGMTRX
# vRfLvYiBxh44iQm6KaDTIa/n6ubuthKqYgvwt+VjxC5t5u+/yumhPWNyCvFc5G2Y
# XfTe3ceIvLMvxIw5+IahX5HppxDLqou/b4uSvxzcWyRprgJ6NlN5rCna0bSJHWu0
# pzp5hfV3+puxxZdrjkfMrBXaDVBbdGuTFMpUw0HmegESzV8MkRYnD73dasas07pq
# iHIBPAbGh5PniuSgS96Uv4ozfkJyR5uMtNATMYICBDCCAgACAQEwYzBMMRMwEQYK
# CZImiZPyLGQBGRYDb3JnMRYwFAYKCZImiZPyLGQBGRYGY2ZvcmF0MR0wGwYDVQQD
# ExRjZm9yYXQtQ0EtT05TSVRFMS1DQQITMQAACfHYqF4b87ZlCgAAAAAJ8TAJBgUr
# DgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMx
# DAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkq
# hkiG9w0BCQQxFgQUWvKDxmDOemQwGWWREeeQZNuE+OYwDQYJKoZIhvcNAQEBBQAE
# ggEAoUI7xSjq0GS516j1DsPQ25iWbj4bKi1PKJe7s1ZK4N3pZHkelBpxiWdO3M8m
# XjWZGlcJgd8gFvNxE+daM1nzrguNbvbEfU1xoa2qsxEHG8MOE7HrdRLLMqmNrZHd
# jOn8n5o9gDk4mHVp8dLCYA+H9EfyHYTGWEMZy8+7rvv3/EK/lwyu+m/c5/yas8i0
# R90odiFvr604PUjo9ZQSWpNzbSOhto6Wld3dqaKZ7MbKbkK1kM6p+Ijglcw5xGD/
# 9zfGDDRT/hQrUahbNh9URLKjKWwM0v7vjrxo2HSQyyd6p5zDot1HF4Vdt2BqAM1J
# 1ydCtya1re464CN3W1te1/ev9g==
# SIG # End signature block
