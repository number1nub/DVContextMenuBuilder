getDatName() {
	RegRead, dat, HKCR, .dat
	return (ErrorLevel ? ".dat" : dat)
}