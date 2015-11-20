regKeyExists(key) {
	keyName := RegExReplace(Trim(key), "i)^DataViewer - ")
	csvSubKey := getCsvName() "\shell\DataViewer - " keyName "\command"
	datSubKey := getDatName() "\shell\DataViewer - " keyName "\command"
	RegRead, v, HKCR, %csvSubKey%
	err := ErrorLevel
	RegRead, v, HKCR, %datSubKey%
	err += ErrorLevel
	return (err ? false : true)
}