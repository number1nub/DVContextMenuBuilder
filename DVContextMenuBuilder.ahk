#NoEnv
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

;--- Script Settings ---
global config    := {Items:{}}
	 , dvPath    := A_ScriptDir "\DataViewer.exe"
	 , devMode   := false
	 , maxHeight := 18
	 , version   := "9.1.1"

CheckCredentials(%true%)
if (InStr(%true%, "uninstall"))
	Uninstall()
CheckFiles()
LoadSettings()
LV_Colors.OnMessage()
BuildGui()
return


#Include <applySettings>
#Include <BuildGui>
#Include <CheckCredentials>
#Include <CheckFiles>
#Include <class LV_Colors>
#Include <getCsvName>
#Include <getCurEntries>
#Include <getDatName>
#Include <getFromYaml>
#Include <getSelItems>
#Include <LoadSettings>
#Include <m>
#Include <objToCsv>
#Include <regKeyExists>
#Include <StyleGUI>
#Include <Uninstall>