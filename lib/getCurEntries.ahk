getCurEntries(appendToList:="") {
	list:=appendToList.Length() ? appendToList : []
	listVals := []
	for c, v in list
		listVals[v] := 1
	Loop, Reg, % "HKCR\" getCsvName() "\shell", K
		if (InStr(A_LoopRegName, "DataViewer - ") && !listVals.HasKey(tmp:=RegExReplace(A_LoopRegName, "^DataViewer - ")))
			list.Push(tmp), listVals[tmp]:=1
	Loop, Reg, % "HKCR\" getDatName() "\shell", K
		if (InStr(A_LoopRegName, "DataViewer - ") && !listVals.HasKey(RegExReplace(A_LoopRegName, "^DataViewer - ")))
			list.Push(tmp), listVals[tmp]:=1
	return list
}