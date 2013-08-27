' Script to disable IPv6
' ---------- Body
'
' by RaveMaker - http://ravemaker.net

DebugMode = "True"

RegResultStr = readfromRegistry("HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\DisabledComponents", "Blank")
If Not (RegResultStr = "-1") Then 
	disableIPv6
	DebugMode1
	If (DebugMode = "True") Then
		msgbox "IPv6 Disabled"
	END if
Else
	If (DebugMode = "True") Then
		msgbox "IPv6 Already Disabled"
	END if
End if

' ---------- Functions
' Read IPv6 Registry Status
Function readFromRegistry (strRegistryKey, strDefault)
	Dim WSHShell, value
	On Error Resume Next
	Set WSHShell = CreateObject("WScript.Shell")
	value = WSHShell.RegRead(strRegistryKey)
	if err.number <> 0 then
		readFromRegistry = strDefault
	else
		readFromRegistry = value
	end if
	set WSHShell = nothing
End function

' Disable IPv6 if needed
Function disableIPv6
		Dim OperationRegistry
		Set OperationRegistry=WScript.CreateObject("WScript.Shell")
		OperationRegistry.RegWrite "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\DisabledComponents",-1, "REG_DWORD"
		Set OpSysSet = GetObject("winmgmts:{(Shutdown)}//./root/cimv2").ExecQuery("select * from Win32_OperatingSystem where Primary=true")
End function
