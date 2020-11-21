LoadSettings(cfgList:="") {
	types := cfgList ? StrSplit(cfgList, ",") : getCurEntries()
	for c, v in types {
		config.Items[v] := (ex:=regKeyExists(v))
		config.Active   .= ex ? (config.Active ? ",":"") v : ""
		config.Count    := A_Index
	}
	if (!config.Count) {
		m("ico:!", "There was a problem getting the list of DataViewer configuration names...", "`nAborting...")
		ExitApp
	}
}