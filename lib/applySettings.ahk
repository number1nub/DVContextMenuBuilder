applySettings(items) {
	if (devMode) {
		m("Currently in DEV mode...",, "Can't write settings.", "ico:!")
		return
	}
	for c, v in items {
		csvKey := getCsvName() "\shell\DataViewer - " c
		datKey := getDatName() "\shell\DataViewer - " c
		if (v = 1) {
			RegWrite, REG_SZ, HKCR, %csvKey%, icon, `"%dv%`"
			RegWrite, REG_SZ, HKCR, %csvKey%\command,, % """" dv """ ""`%1"" """ c """"
			RegWrite, REG_SZ, HKCR, %datKey%, icon, `"%dv%`"
			RegWrite, REG_SZ, HKCR, %datKey%\command,, % """" dv """ ""`%1"" """ c """"
		}
		else {
			RegDelete, HKCR, %csvKey%
			RegDelete, HKCR, %datKey%
		}
	}
	return 1
}