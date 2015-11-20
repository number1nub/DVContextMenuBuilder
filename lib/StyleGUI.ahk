StyleGUI(ctl, color1, color2:="0xFFFFFF", title:="A") {	
	WinGetPos,,, ww,, % title
	ControlMove, Submit, % (ww / 2) - 50,,,, % title
	while row := LV_GetNext(row, "C")
		LV_Colors.Row(ctl, row, 0xA4D1FF)
	GuiControl, +Redraw, %ctl%
}