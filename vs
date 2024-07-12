#!/usr/bin/env pwsh

# this is a script launch vscode in specific profile by the directory.
#

function Get-ProjectType {
  param(
    [string]$Directory
  )
  if (Test-Path "$Directory\*.cabal") {
    return "haskell"
  } elseif (Test-Path "$Directory\*.sbt") {
    return "scala"
  } elseif ((Test-Path "$Directory\*.csproj") -or (Test-Path "$Directory\*.fsproj")) {
    return "dotnet"
  } elseif (Test-Path "$Directory\package.json") {
    return "web"
  } else {
    return "Default"
  } 
}

$currentDir = Get-Location
$projectType = Get-ProjectType -Directory $currentDir

code --profile $projectType $currentDir
