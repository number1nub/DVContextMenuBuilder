BuildGui(title:="DV Context Menu Editor") {
	static ItemList, BtnSubmit, origList
	
	Gui, +AlwaysOnTop -MinimizeBox
	Gui, Margin, 10, 5
	Gui, Font, s22, Segoe UI
	Gui, Add, Text,, Select Menu Items
	Gui, Font, s12
	Gui, Add, ListView, % "y+5 checked +NoSortHdr +Grid AltSubmit hwndItemListID vItemList gListSelectionChange R" (config.Items.Count()<=maxHeight ? config.Items.Count() : maxHeight), Configurations
	origList := ""
	for c, v in config.Items
		LV_Add(v ? "Check":"", c), origList.=v ? (origList?",":"") c : ""
	Gui, Add, Button, y+5 w100 h40 hwndBtnSubmitID vBtnSubmit gSubmitChanges, Submit
	Gui, Show,, % title:=(title (Version ? " v" Version : ""))
	
	LV_Colors.Attach(ItemListID, 1)
	StyleGUI(ItemListID, 0xEFEFEF, title)
	return
	
	
	ListSelectionChange:	;{
		if (A_GuiControlEvent = "I" && ErrorLevel = "c") {
			ControlGet, id, Hwnd,, SysListView321
			loop % LV_GetCount()
				LV_Colors.Row(id, A_Index, 0xFFFFFF)
			while row := LV_GetNext(row, "C")
				LV_Colors.Row(id, row, 0xA4D1FF)
		}
	return	;}
	
	
	SubmitChanges:	;{
		selItems := [], row = 0
		for c, v in config.Items
			selItems.Insert(c, 0)
		while row:=LV_GetNext(row, "C") {
			LV_GetText(t, row, 1)
			selItems[t] := 1
		}
		if applySettings(selItems)
			m("Done!",, "Your context menu items have been updated.","ico:i")
	ExitApp	;}
	
	
	GuiClose:
	GuiEscape:	;{		
		if (origList != objToCsv(getSelItems()))
			if (m("ico:?", "btn:ync", "title:Unsaved Changes", "Are you sure you want to exit and discard changes?")!="YES")
				return
	ExitApp	;}
}