$Directories = @("Contacts", "Desktop", "Documents", "Downloads", "Favorites", "Links", "Music", "Pictures", "Saved Games", "Searches", "Videos")
$CurrentDate = Get-Date -Format "yyyyMMddHHmmss"

foreach($Directory in $Directories) {
	#バックアップを作成
	Copy-Item "$env:USERPROFILE\$Directory\desktop.ini" "$env:USERPROFILE\$Directory\desktop.ini.$CurrentDate"
	
	# desktop.iniの内容を取得
	$DesktopIni = Get-Content "$env:USERPROFILE\$Directory\desktop.ini"
	
	# システム属性がついているとファイルを編集できないため、desktop.iniのシステムファイル属性を解除
	cmd /c attrib "$env:USERPROFILE\$Directory\desktop.ini" -s -h

	# ローカライズ設定を解除
	$DesktopIni.Replace("LocalizedResourceName", ";LocalizedResourceName") > "$env:USERPROFILE\$Directory\desktop.ini"

	# desktop.iniにシステムファイル属性を付与
	cmd /c attrib "$env:USERPROFILE\$Directory\desktop.ini" +s +h
}