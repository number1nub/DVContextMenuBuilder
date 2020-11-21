regKeyExists(key) {
	keyName   := RegExReplace(Trim(key), "i)^DataViewer - ")
	csvSubKey := getCsvName() "\shell\DataViewer - " keyName "\command"
	datSubKey := getDatName() "\shell\DataViewer - " keyName "\command"
	RegRead, v1, HKCR\%csvSubKey%
	RegRead, v2, HKCR\%datSubKey%
	return ((v1 || v2) ? true : false)
}