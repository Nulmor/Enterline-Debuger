#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%


fileName = %A_ScriptDir%\DebugLines.txt
file := FileOpen(fileName, "r")

PasteLine(line)
{
	clipBackup := Clipboard
	Clipboard := line
	;Send, {Enter}
	Send, ^v
	Sleep, 100
	Clipboard := clipBackup
}
	
if !isObject(file)
		Msgbox, Can't open vars file.
else
{
	tempLine = ""
	
	loop
	{
		KeyWait, Enter, D
		SoundPlay, C:\Windows\Media\ding.wav
		
		tempLine := file.ReadLine()
		PasteLine(tempLine)

		if (file.atEOF)
			break
	}
	Send, {Enter}
}
file.Close
SoundPlay, C:\Windows\Media\tada.wav, 1
ExitApp

*SC029::
	Suspend, Off
	if scriptActive = 0
	{
		scriptActive := 1
		SoundPlay, C:\Windows\Media\Speech On.wav
		KeyWait, SC029
		Suspend, Off
		}
	Else
	{
		scriptActive := 0
		SoundPlay, C:\Windows\Media\Speech Off.wav
		KeyWait, SC029
		Suspend, On
		}
Return

Enter::
	; Do Nothing...
Return

*f11::
	Run, %A_ScriptDir%\%A_ScriptName%
Return

*f12::
	Suspend, Off
ExitApp