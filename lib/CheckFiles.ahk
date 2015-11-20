CheckFiles(){
	if (!FileExist(dv)) {
		if (A_IsCompiled){
			m("DataViewer.exe was not found!",,"This utility must be run via the DataViewer 'Edit Context Menu' option.","ico:!")
			ExitApp
		}
		devMode := true
	} ;#[TODO: Check for & get config list from dataviewer_filetypes.xml]
}