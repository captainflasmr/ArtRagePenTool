#SingleInstance, force
SetTitleMatchMode, RegEx

ArtName = ArtRage

Gui, +Resize +LastFound +AlwaysOnTop +E0x08000000 +ToolWindow +Border
Gui, Margin, 5, 5
Gui, Color, 333333
Gui, Font, s8 cffffff, Verdana
Gui, Add, Text, x5 y2 gArtPrepare, %ArtName%
Gui, Add, Button, x5 w40 h30 gArtSmaller, [
Gui, Add, Button, x+5 w40 h30 gArtBigger, ]
Gui, Add, Slider, x+5 w120 h25 Range1-100 vMyUpDown NoTicks, 10
Gui, Add, Button, x5 w40 h30 gArtResize, Size
Gui, Add, Button, x+5 w40 h30 gUndo, <
Gui, Add, Button, x+5 w40 h30 gRedo, >
Gui, Add, Button, x+5 w40 h30 gArtDeselect, Deselect
Gui, Add, Button, x5 w40 h30 gArtPick, Pick
Gui, Add, Button, x+5 w40 h30 gArtTransform, Transform
Gui, Add, Button, x+5 w40 h30 gArtWarp, Warp
Gui, Add, CheckBox, x+5 w40 h30 gArtFlip, Flip
Gui, Add, Button, x+5 w40 h30 gArtCanvasFlip, Flip
Gui, Show, NoActivate x1450 y320
return

Undo:
	WinActivate, ahk_exe %ArtName%.exe
	Send ^z
	return

Redo:
	WinActivate, ahk_exe %ArtName%.exe
	Send ^y
	return
	
ArtResize:
	WinActivate, ahk_exe %ArtName%.exe
	Send {Shift Down}
	sleep 1500
	Send {Shift Up}
	return
	
ArtFlip:
	WinActivate, ahk_exe %ArtName%.exe
	GetKeyState, state, h
	if state = D
		Send {h up}
	else
		Send {h down}
	return
	
ArtPick:
	WinActivate, ahk_exe %ArtName%.exe
	Send {LAlt Down}
	sleep 1500
	Send {LAlt Up}
	return
	
ArtTransform:
	WinActivate, ahk_exe %ArtName%.exe
	Send ^!+t
	return
	
ArtWarp:
	WinActivate, ahk_exe %ArtName%.exe
	Send ^w
	return
	
ArtCanvasFlip:
	WinActivate, ahk_exe %ArtName%.exe
	Send,^!l
	Send,h
	Send,{Enter}
	return
	
ArtPrepare:
	WinActivate, ahk_exe nomacs.exe
	WinSet, Style, ^0xC00000, ahk_exe nomacs.exe
	Winset, Alwaysontop, , ahk_exe nomacs.exe
	WinActivate, ahk_exe obs64.exe
	WinSet, Style, ^0xC00000, ahk_exe obs64.exe
	return
	
ArtSmaller:
	WinActivate, ahk_exe %ArtName%.exe
	Gui, Submit, NoHide
	Send {[ %MyUpDown%}
	return
	
ArtBigger:
	WinActivate, ahk_exe %ArtName%.exe
	Gui, Submit, NoHide
	Send {] %MyUpDown%}
	return
	
ArtDeselect:
	WinActivate, ahk_exe %ArtName%.exe
	Send ^d
	return
	
ArtExit:
	ExitApp
	return
