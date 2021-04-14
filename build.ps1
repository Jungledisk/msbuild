#!/usr/bin/env pwsh
param (
  [string]$Csproj,
  [string]$PublishProfile,
  [string]$Configuration = "Debug"
)

msbuild /p:DeployOnBuild=true `
        /p:PublishProfile="$(Get-Location)/Web/Properties/PublishProfiles/$PublishProfile.pubxml" `
        /p:Configuration=$Configuration `
        $Csproj | Tee-Object -Variable buildLog


$packagePath = ($buildLog | select-string '(?<=Packaging into )(.*)(?=.)')[0].Matches[0].Value
Write-Output "::set-output name=package-path::$packagePath"