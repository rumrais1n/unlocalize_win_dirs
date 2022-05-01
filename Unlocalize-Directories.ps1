$Directories = @("Contacts", "Desktop", "Documents", "Downloads", "Favorites", "Links", "Music", "Pictures", "Saved Games", "Searches", "Videos")
$CurrentDate = Get-Date -Format "yyyyMMddHHmmss"

foreach($Directory in $Directories) {
	# Make a backup file
	Copy-Item "$env:USERPROFILE\$Directory\desktop.ini" "$env:USERPROFILE\$Directory\desktop.ini.$CurrentDate"
	
	# Get content on desktop.ini
	$DesktopIni = Get-Content "$env:USERPROFILE\$Directory\desktop.ini"
	
	# Unset system file attribution to edit desktop.ini
	cmd /c attrib "$env:USERPROFILE\$Directory\desktop.ini" -s -h

	# Unset localize settings
	$DesktopIni.Replace("LocalizedResourceName", ";LocalizedResourceName") > "$env:USERPROFILE\$Directory\desktop.ini"

	# Set system file attribution again
	cmd /c attrib "$env:USERPROFILE\$Directory\desktop.ini" +s +h

	# Restart Explorer
	Stop-Process -Name Explorer -Force
	Start-Process -FilePath "C:\Windows\explorer.exe"
}