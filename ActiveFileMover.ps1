#Source
$sourcePath = "\\server\Tempfolder\Company_01" # Need To Change

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $sourcePath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$action = {
  #Destination
	$destinationPath = "C:\Folder\Tempfolder\Copy location" #Need To Change
 
	$sourceFile = $event.SourceEventArgs.FullPath
	write-host "Source: $sourceFile"
	$destinationFile = Join-Path $destinationPath (Split-Path $sourceFile -Leaf)
	Write-Host "Destination: $destinationFile"
	Move-Item $sourceFile -destination $destinationFile -Force
	Write-Host "______________________Sorted______________________"
}

try {
	Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action $action

	write-host "Monitoring $sourcePath for changes..."
	while ($true) {start-sleep -seconds 1}
}
catch {
	write-host "An Error occurred:"
	write-host $_.scriptStackTrace
}
