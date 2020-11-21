CheckCredentials(attempts:="", silent:="") {
	if (devmode)
		return
	if (!A_IsAdmin) {
		if (!silent)
			ans := silent ? "Retry" : m("Administrator credentials are required...`n`nPress RETRY to attempt re-launching as admin.", "title:Insufficent User Access", "btn:rc", "ico:!")
		if (!attempts && ans="Retry")
			run *RunAs "%A_ScriptFullPath%"
		ExitApp
	}
}