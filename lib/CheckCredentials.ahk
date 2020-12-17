CheckCredentials(info:="") {
	if (devMode)
		return 1
	if (!A_IsAdmin) {
		if (info = "admin") {
			if (m("ico:!", "btn:rc","Admin credentials required.`n", "Press RETRY to attempt re-launching as admin.")!="RETRY")
				ExitApp
		}
		Run, *RunAs "%A_ScriptFullPath%" admin
		ExitApp
	}
	return 1
}