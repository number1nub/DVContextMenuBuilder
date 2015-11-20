Uninstall(attempts) {
	CheckCredentials(attempts, 1)
	csvSubKey := getCsvName() "\shell"
	datSubKey := getDatName() "\shell"
	Loop, HKCR, %csvSubKey%, 1
		if (InStr(A_LoopRegName, "DataViewer - "))
			RegDelete
	Loop, HKCR, %datSubKey%, 1
		if (InStr(A_LoopRegName, "DataViewer - "))
			RegDelete
	ExitApp
}