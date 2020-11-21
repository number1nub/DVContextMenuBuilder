#NoEnv
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

global config:={Items:{}, Active:"", Count:0}, dv:=A_ScriptDir "\DataViewer.exe", devMode:="", version:="1.2.0"

if (InStr(%true%, "uninstall")) {
	attempts = %2%
	Uninstall(attempts)
}
CheckFiles()
CheckCredentials()
LoadSettings(%true%)
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
#Include <getSelItems>
#Include <LoadSettings>
#Include <m>
#Include <objToCsv>
#Include <regKeyExists>
#Include <StyleGUI>
#Include <Uninstall>