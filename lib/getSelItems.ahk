getSelItems() {
	selItems:=[], row:=0
	while row:=LV_GetNext(row, "C") {
		LV_GetText(t, row, 1)
		selItems.Push(t)
	}
	return selItems
}