#SingleInstance, force
SetTitleMatchMode, RegEx

ArtName = ArtRage

Gui, +Resize +LastFound +AlwaysOnTop +E0x08000000 +ToolWindow +Border
Gui, Margin, 5, 5
Gui, Color, 333333
Gui, Font, s8 cffffff, Verdana
Gui, Add, Text, x5 y2 gArtPrepare, %ArtName%
Gui, Add, Slider, x+5 w170 h15 Range50-255 vMyTransparency gMyTransparency NoTicks, 255
Gui, Add, Button, x5 w40 h30 gArtSmaller, [
Gui, Add, Button, x+5 w40 h30 gArtBigger, ]
Gui, Add, Slider, x+5 w85 h20 Range1-100 vMyUpDown NoTicks, 10
Gui, Add, Button, x+5 w40 h30 gArtMergeDown, Merg
Gui, Add, Button, x5 w40 h30 gArtResize, Size
Gui, Add, Button, x+5 w40 h30 gUndo, <
Gui, Add, Button, x+5 w40 h30 gRedo, >
Gui, Add, Button, x+5 w40 h30 gArtTransform, T
Gui, Add, Button, x+5 w40 h30 gArtDeselect, Desel
Gui, Add, Button, x5 w40 h30 gArtPick, Pick
Gui, Add, CheckBox, x+5 w40 h30 gArtFlip, Flip
Gui, Add, Button, x+5 w40 h30 gArtCanvasFlip, Flip
Gui, Add, Button, x+5 w40 h30 gArtCut, Cut
Gui, Add, Button, x+5 w40 h30 gArtPaste, Paste
Gui, Add, Button, x5 w40 h30 gArtCanvasMove, M
Gui, Add, Button, x+5 w40 h30 gArtCanvasZoom, Z
Gui, Add, Button, x+5 w40 h30 gArtCanvasZoomOut, -
Gui, Add, Button, x+5 w40 h30 gArtCanvasZoomIn, +
Gui, Add, Button, x+5 w40 h30 gArtWarp, Warp
Gui, Show, NoActivate x1450 y320, ArtRageTool
return

Undo:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^z
	return

Redo:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^y
	return
	
ArtResize:
	WinRestore, ahk_exe %ArtName%.exe
	Send {Shift Down}
	sleep 1500
	Send {Shift Up}
	return
	
ArtFlip:
	WinRestore, ahk_exe %ArtName%.exe
	GetKeyState, state, h
	if state = D
		Send {h up}
	else
		Send {h down}
	return
	
ArtPick:
	WinRestore, ahk_exe %ArtName%.exe
	Send {LAlt Down}
	sleep 1500
	Send {LAlt Up}
	return
	
ArtTransform:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^!+t
	return
	
ArtWarp:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^w
	return
	
ArtCanvasFlip:
	WinRestore, ahk_exe %ArtName%.exe
	Send,^!l
	Send,h
	Send,{Enter}
	return
	
ArtPrepare:
	WinRestore, ahk_exe nomacs.exe
	WinSet, Style, ^0xC00000, ahk_exe nomacs.exe
	Winset, Alwaysontop, , ahk_exe nomacs.exe
	WinRestore, ahk_exe obs64.exe
	WinSet, Style, ^0xC00000, ahk_exe obs64.exe
	WinSet, Transparent, 64, ArtRageTool
	return
	
ArtSmaller:
	WinRestore, ahk_exe %ArtName%.exe
	Gui, Submit, NoHide
	Send {[ %MyUpDown%}
	return
	
ArtBigger:
	WinRestore, ahk_exe %ArtName%.exe
	Gui, Submit, NoHide
	Send {] %MyUpDown%}
	return
	
ArtDeselect:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^d
	return
	
ArtClearLayer:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^+c
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
	Send ^-
	return
	
ArtCanvasZoomIn:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^+=
	return
	
ArtCut:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^x
	return
	
ArtPaste:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^v
	return
	
MyTransparency:
	Gui, Submit, NoHide
	WinSet, Transparent, %MyTransparency%, ArtRageTool
	return
	
ArtMergeDown:
	WinRestore, ahk_exe %ArtName%.exe
	Send ^!{Down}
	return

