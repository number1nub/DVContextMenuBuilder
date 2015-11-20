getCsvName() {
	RegRead, csv, HKCR, .csv
	return (ErrorLevel ? ".csv" : csv)
}