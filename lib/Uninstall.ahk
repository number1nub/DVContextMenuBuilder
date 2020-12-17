Uninstall() {
	csvSubKey := getCsvName() "\shell"
	datSubKey := getDatName() "\shell"
	Loop, Reg, HKCR\%csvSubKey%, K
		if (InStr(A_LoopRegName, "DataViewer - "))
			RegDelete
	Loop, Reg, HKCR\%datSubKey%, K
		if (InStr(A_LoopRegName, "DataViewer - "))
			RegDelete
	m("ico:i", "DataViewer Context Menu Uninstall", "DataViewer context menu items have been removed.")
	ExitApp
}