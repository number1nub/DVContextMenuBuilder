CheckFiles(){
	if (!FileExist(dvPath)) {
		if (A_IsCompiled){
			m("ico:!", "DataViewer.exe was not found!`n", "This utility must be run in the DataViewer folder")
			ExitApp
		}
		devMode := true
	}
}