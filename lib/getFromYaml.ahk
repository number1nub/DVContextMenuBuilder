getFromYaml() {
	if (!yPath:=FileExist(tmp:=A_WorkingDir "\config\DataViewer_filetypes.yml")?tmp:(FileExist(tmp:=A_WorkingDir "\DataViewer_filetypes.yml")?tmp:""))
		return
	cfgList := []
	Loop, Read, %yPath%
		if (RegExMatch(A_LoopReadLine, "^\s{4}Name:\s+(?P<Name>.+)\s*$", cfg))
			cfgList.Push(cfgName)
	return cfgList
}