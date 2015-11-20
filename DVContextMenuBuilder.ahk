#NoEnv
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

global config:={Items:{}, Active:"", Count:0}, dv:=A_ScriptDir "\DataViewer.exe", devMode:=""

if (InStr(%true%, "uninstall")) {
	attempts = %2%
	Uninstall(attempts)
}
CheckCredentials()
CheckFiles()
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
#Include <getDatName>
#Include <getSelItems>
#Include <LoadSettings>
#Include <m>
#Include <objToCsv>
#Include <regKeyExists>
#Include <StyleGUI>
#Include <Uninstall>