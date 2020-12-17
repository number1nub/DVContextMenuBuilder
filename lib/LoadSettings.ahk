LoadSettings() {
	if (devMode)
		SetWorkingDir, C:\Users\rameen\Source\TVDS Azure Dev\DataViewer\Config Files
	types := getCurEntries(getFromYaml())
	for c, v in types
		config.Items[v] := regKeyExists(v)
	if (!config.Items.Count()) {
		m("ico:!", "There was a problem getting the list of DataViewer configuration names...", "`nAborting...")
		ExitApp
	}
}