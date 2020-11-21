Uninstall(attempts) {
	CheckCredentials(attempts, 1)
	csvSubKey := getCsvName() "\shell"
	datSubKey := getDatName() "\shell"
	Loop, Reg, HKCR\%csvSubKey%, K
		if (InStr(A_LoopRegName, "DataViewer - "))
			RegDelete
	Loop, Reg, HKCR\%datSubKey%, K
		if (InStr(A_LoopRegName, "DataViewer - "))
			RegDelete
	ExitApp
}