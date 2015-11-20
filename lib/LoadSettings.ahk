LoadSettings(cfgList:="") {
	types := cfgList ? StrSplit(cfgList, ",") : ["CommSub","CommSub DC Status Bits","DC Status Bits","DC2 Status Bits","Engineering Dyno Standard","FlowLoop","MC Status Bits","North Dyno Standard","Rig Data","RSS Tool Data - v80-8x","RTC Rig Site Data","Sakor Dyno Standard","South Dyno Standard","SteeringSub","Torque Logger"]
	for c, v in types {
		config.Items[v] := (ex:=regKeyExists(v))
		config.Active   .= ex ? (config.Active ? ",":"") v : ""
		config.Count    := A_Index
	}
	
}