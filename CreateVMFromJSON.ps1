# Load VM configuration from JSON file
$configPath = ".\vmconfig.json"
$config = Get-Content $configPath | ConvertFrom-Json

# Create VHD if it doesn't exist
if (-not (Test-Path $config.VHDPath)) {
    New-VHD -Path $config.VHDPath -SizeBytes $config.VHDSizeBytes -Dynamic
}

# Create VM
New-VM -Name $config.VMName `
       -MemoryStartupBytes $config.MemoryStartupBytes `
       -VHDPath $config.VHDPath `
       -Generation $config.Generation `
       -SwitchName $config.SwitchName

Write-Host "VM '$($config.VMName)' created successfully."