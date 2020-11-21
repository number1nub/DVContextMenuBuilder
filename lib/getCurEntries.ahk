getCurEntries() {
	list := []
	Loop, Reg, % "HKCR\" getCsvName() "\shell", K
		if (InStr(A_LoopRegName, "DataViewer - "))
			list.Push(RegExReplace(A_LoopRegName, "^DataViewer - "))
	Loop, Reg, % "HKCR\" getDatName() "\shell", K
		if (InStr(A_LoopRegName, "DataViewer - "))
			list.Push(RegExReplace(A_LoopRegName, "^DataViewer - "))
	return list
}