BuildGui(title:="DV Context Menu Editor") {
	static ItemList, BtnSubmit, Version
	
	;auto_version
	Gui, +AlwaysOnTop -MinimizeBox
	Gui, Margin, 10, 5
	Gui, Font, s22, Segoe UI
	Gui, Add, Text,, Select Menu Items
	Gui, Font, s12
	Gui, Add, ListView, % "y+5 checked -Sort +NoSortHdr +Grid AltSubmit hwndItemListID vItemList gListSelectionChange R" config.Count, Configurations
	for c, v in config.Items
		LV_Add(v ? "Check":"", c)
	Gui, Add, Button, y+5 w100 h40 hwndBtnSubmitID vBtnSubmit gSubmitChanges, Submit
	Gui, Show,, % title:=(title (Version?" v" Version:""))
	
	LV_Colors.Attach(ItemListID, 1)
	StyleGUI(ItemListID, 0xEFEFEF, title)
	return
	
	ListSelectionChange:
	/*
		if (A_GuiEvent = "DoubleClick") { ;Allow double-clicking to check/uncheck
			Gui +LastFound
			SendMessage, 4140, % A_EventInfo - 1, 0xF000, SysListView321
			if !ErrorLevel
				return
			IsChecked := (ErrorLevel >> 12) - 1
			LV_Modify(A_EventInfo, IsChecked ? "-Check" : "Check")
		}
	*/
	if (A_GuiControlEvent = "I" && ErrorLevel = "c") {
		ControlGet, id, Hwnd,, SysListView321
		loop % LV_GetCount()
			LV_Colors.Row(id, A_Index, 0xFFFFFF)
		while row := LV_GetNext(row, "C")
			LV_Colors.Row(id, row, 0xA4D1FF)
	}
	return
	
	SubmitChanges:
	selItems := [], row = 0
	for c, v in config.Items
		selItems.Insert(c, 0)
	while row:=LV_GetNext(row, "C") {
		LV_GetText(t, row, 1)
		selItems[t] := 1
	}
	if applySettings(selItems)
		m("Done!",, "Your context menu items have been updated.","ico:i")
	ExitApp
	
	GuiClose:
	GuiEscape:
	if (config.Active != objToCsv(getSelItems())) {
		MsgBox, 4148, Unsaved Changes, Are you sure you want to exit and discard changes?
		IfMsgBox, Yes
			ExitApp
		return
	}
	ExitApp
}