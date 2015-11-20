objToCsv(o, ind:=2) {
	if (!IsObject(o))
		return
	tmp := ""
	for c, v in o
		tmp .= (tmp ? "," : "") (ind = 1 ? c : v)
	return tmp
}