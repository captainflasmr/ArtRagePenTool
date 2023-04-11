#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#InstallKeybdHook
#InstallMouseHook
#SingleInstance, force

Padding := 4
PaddingL := Padding + 10
CustomColor := "333333"
ButtonWidth := 35
ButtonWidthL := (ButtonWidth * 2) + Padding
ButtonWidthS := ButtonWidth - Padding
ButtonHeight := 30
FontSize := ButtonWidth / 5
xStart := 1450
yStart := 320

Gui, -Resize +AlwaysOnTop +E0x08000000 +ToolWindow +Border +LastFound
Gui, Color, %CustomColor%
Gui, Font, s%FontSize% cffffff, Verdana

Gui, Add, Tab3,, |.

Gui, Tab, 1

Gui, Add, Button, x%PaddingL% y+%Padding% w%ButtonWidth% h%ButtonHeight%  gArtColourPopup, C
Gui, Add, Button, x+%Padding% wp hp gArtCanvasZoomOut, -
Gui, Add, Button, x+%Padding% wp hp gArtCanvasZoomIn, +
Gui, Add, CheckBox, x+%PaddingL% w%PaddingL% hp gArtFlip,
Gui, Add, Button, x%PaddingL% y+%Padding% w%ButtonWidthL% h%ButtonHeight% gArtResize, Shift
Gui, Add, Button, x+%Padding% w%ButtonWidth% hp gUndo, <
Gui, Add, Button, x+%Padding% wp hp gRedo, >

Gui, Tab, 2

Gui, Add, Button, x%PaddingL% y+%Padding% w%ButtonWidth% h%ButtonHeight% gArtCut, Cut
Gui, Add, Button, x+%Padding% wp hp gArtPaste, Paste
Gui, Add, Button, x+%Padding% wp hp gArtTransform, T
Gui, Add, Button, x+%Padding% wp hp gArtPick, Alt
Gui, Add, Button, x%PaddingL% wp hp y+%Padding% gArtDeselect, Desel
Gui, Add, Button, x+%Padding% wp hp gArtControl, Ctrl
Gui, Add, Button, x+%Padding% wp hp gArtWarp, Warp
Gui, Add, Button, x+%Padding% wp hp gArtColour, Col

Gui, Show, NoActivate x%xStart% y%yStart%, ArtRageTool
return

ArtResize:
	WinRestore, ahk_exe %ArtName%.exe
	Send {Shift Down}
	sleep 1500
	Send {Shift Up}
	return
	
Undo:
	WinRestore, ahk_exe %ArtName%.exe
	SendInput, ^z
	return

Redo:
	WinRestore, ahk_exe %ArtName%.exe
	SendInput, ^y
	return
	
ArtControl:
	WinRestore, ahk_exe %ArtName%.exe
	Send {Control Down}
	sleep 1500
	Send {Control Up}
	return
	
ArtPick:
	WinRestore, ahk_exe %ArtName%.exe
	Send {LAlt Down}
	sleep 1000
	Send {LAlt Up}
	return
	
ArtFlip:
	WinRestore, ahk_exe %ArtName%.exe
	GetKeyState, state, h
	if state = D
		Send {h up}
	else
		Send {h down}
	return
	
ArtTransform:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^!+t
	return
	
ArtDeselect:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^d
	return
	
ArtCut:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^x
	return
	
ArtCopy:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^c
	return
	
ArtPaste:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^v
	return
	
ArtColour:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^j
	return
	
ArtWarp:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send, ^w
	return
	
ArtCanvasZoomOut:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^-
	return
	
ArtCanvasZoomIn:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^+=
	return
	
ArtColourPopup:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^+c
	return
