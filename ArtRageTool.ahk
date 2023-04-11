#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#InstallKeybdHook
#InstallMouseHook
#SingleInstance, force

ArtName = ArtRage
CaptionToggle := 0
CustomColor := "333333"
ButtonWidth := 40
ButtonHeight := 25
Padding := 5
FontSize := ButtonWidth / 5
SliderWidth := ButtonWidth*4+(Padding*3)
TransWidth := SliderWidth - (7*FontSize)
xStart := 1450
yStart := 320

Gui, -Resize +AlwaysOnTop +E0x08000000 +ToolWindow +Border +LastFound
Gui, Color, %CustomColor%
Gui, Font, s%FontSize% cffffff, Verdana
Gui, Add, Text, x%Padding% gArtBorder, %ArtName%
Gui Add, Progress, x+%Padding% w%TransWidth% Background%CustomColor% Range0-100 vSliderBackground,0
Gui, Add, Button, x%Padding% y+%Padding% w%ButtonWidth% h%ButtonHeight% gArtCut, Cut
Gui, Add, Button, x+%Padding% wp hp gArtCopy, Copy
Gui, Add, Button, x+%Padding% wp hp gArtPaste, Paste
Gui, Add, Button, x+%Padding% wp hp gArtDeselect, Desel
Gui, Add, Button, x%Padding% y+%Padding% w%ButtonWidth% h%ButtonHeight% gArtPick, Pick
Gui, Add, Button, x+%Padding% wp hp gArtTransform, T
Gui, Add, Button, x+%Padding% wp hp gArtMergeDown, Down
Gui, Add, Button, x+%Padding% wp hp gArtLayerDuplicate, Dup
Gui, Add, Button, x%Padding% y+%Padding% w%ButtonWidth% h%ButtonHeight% gArtResize, Size
Gui, Add, Button, x+%Padding% wp hp gUndo, <
Gui, Add, Button, x+%Padding% wp hp gRedo, >
Gui, Add, Button, x+%Padding% wp hp gArtControl, Ctrl
Gui, Add, Slider, x%Padding% hp w%SliderWidth% Range1-100 vMyTransparent gArtLayerTransparent TickInterval25 Tooltip, 100
Gui, Add, CheckBox, x%Padding% w%ButtonWidth% h%ButtonHeight% gArtFlip, F
Gui, Add, CheckBox, x+%Padding% wp hp gArtLayerVisible, V
Gui, Add, Button, x+%Padding% wp hp gArtCanvasFlip, Flip
Gui, Add, Button, x+%Padding% wp hp gArtWarp, Warp
Gui, Add, Button, x5 y+5 w40 h30 gArtCanvasMove, M
Gui, Add, Button, x+5 w40 h30 gArtCanvasZoom, Z
Gui, Add, Button, x+5 w40 h30 gArtCanvasZoomOut, -
Gui, Add, Button, x+5 w40 h30 gArtCanvasZoomIn, +
Gui, Show, NoActivate x%xStart% y%yStart%, ArtRageTool

OnMessage(0x201, "WM_LBUTTONDOWN")
return

WM_LBUTTONDOWN(wParam, lParam, msg, hwnd)
{
	MouseGetPos,,,,ctrl,2
	GuiControlGet, hwndSliderBackground, Hwnd, SliderBackground

	tx := lParam & 0xFFFF
	ty  := lParam >> 16
	
    if(ctrl=hwndSliderBackground) {
		MyTransparency:=(tx*2)
		WinSet, Transparent, %MyTransparency%, ArtRageTool
	}
	
	return
}

ArtBorder:
	WinSet, Style, ^0xC00000, ArtRageTool
	WinGetPos,X,Y,W,H,ArtRageTool
	CaptionToggle++
	If ( mod(CaptionToggle, 2) == 0 )
	{
	  H-=2
	  W-=0
    }
	else {
	  H-=27
	  W-=7
	}
	Gui, Show, w%W% h%H%
	return
	
MyTransparency:
	WinSet, Transparent, %MyTransparency%, ArtRageTool
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
	sleep 1500
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
	
ArtMergeDown:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^!{Down}
	return
	
ArtLayerDuplicate:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^!d
	return
	
ArtDeselect:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^d
	return
	
ArtLayerVisible:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^+v
	return
	
ArtLayerTransparent:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^o
	WinRestore, ahk_class ToolWindow
	Send %MyTransparent%, {Enter}
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
	
ArtCanvasFlip:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send,^!l
	Send,h
	Send,{Enter}
	return
	
ArtWarp:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send, ^w
	return
	
ArtCanvasMove:
	WinRestore, ahk_exe %ArtName%.exe
	Send {Space Down}
	sleep 1500
	Send {Space Up}
	return
	
ArtCanvasZoom:
	WinRestore, ahk_exe %ArtName%.exe
	Send {Space Down}
	Send {Shift Down}
	sleep 1500
	Send {Space Up}
	Send {Shift Up}
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
