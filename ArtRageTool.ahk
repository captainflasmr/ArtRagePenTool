#SingleInstance, force
SetTitleMatchMode, RegEx

ArtName = ArtRage
CaptionToggle = 0

Gui, -Resize +AlwaysOnTop +E0x08000000 +ToolWindow +Border
Gui, Margin, 5, 5
Gui, Color, 333333
Gui, Font, s8 cffffff, Verdana
Gui, Add, Text, x5 y+2 gArtBorder, %ArtName%
Gui, Add, Text, x+1 w5 gArtHidden,
Gui, Add, Slider, x+5 w110 h15 Range50-255 vMyTransparency gMyTransparency NoTicks, 255
Gui, Add, Tab3, x5 w180, Common|Other
Gui, Tab, 1
Gui, Add, Button, x5 y+5 w40 h30 gUndo, <
Gui, Add, Button, x+5 w40 h30 gArtResize, Size
Gui, Add, Button, x+5 w40 h30 gRedo, >
Gui, Add, CheckBox, x5 y+5 w40 h30 gArtFlip, Flip
Gui, Add, Button, x+5 w40 h30 gArtPick, Pick
Gui, Add, Button, x+5 w40 h30 gArtCanvasFlip, Flip All
Gui, Add, Button, x+5 w40 h30 gArtTransform, T
Gui, Add, Button, x5 y+5 w40 h30 gArtCanvasMove, M
Gui, Add, Button, x+5 w40 h30 gArtCanvasZoom, Z
Gui, Add, Button, x+5 w40 h30 gArtCanvasZoomOut, -
Gui, Add, Button, x+5 w40 h30 gArtCanvasZoomIn, +
Gui, Add, Slider, x5 y+5 w180 h30 Range1-100 vMyTransparent gArtTest TickInterval25 Tooltip, 100
Gui, Tab, 2
Gui, Add, Slider, x5 y+5 w150 h30 Range1-200 vMyUpDown gArtBrushSize TickInterval25 Tooltip, 20
Gui, Add, Text, x+2 w20 h30 vUpDownLabel, 20
Gui, Add, Button, x5 y+5 w40 h30 gArtSmaller, [
Gui, Add, Button, x+5 w40 h30 gArtBigger, ]
Gui, Add, Button, x+5 w40 h30 gArtDeselect, Desel
Gui, Add, Button, x+5 w40 h30 gArtColour, Color
Gui, Add, Button, x5 y+5 w40 h30 gArtCut, Cut
Gui, Add, Button, x+5 w40 h30 gArtCopy, Copy
Gui, Add, Button, x+5 w40 h30 gArtPaste, Paste
Gui, Add, Button, x+5 w40 h30 gArtWarp, Warp
Gui, Show, NoActivate x1450 y320, ArtRageTool
return

ArtBorder:
	WinSet, Style, ^0xC00000, ArtRageTool
	WinGetPos,X,Y,W,H,ArtRageTool
	If ( mod(CaptionToggle++, 2) == 0 )
	{
	  H-=27
	  W-=6
    }
	else {
	  H-=2
	  W-=1
	}
	Gui, Show, w%W% h%H%
	return
	
ArtHidden:
	WinGet, id, List, ahk_exe nomacs.exe,,
	Loop, %id%
	{
    this_id := id%A_Index%
	WinSet, Style, ^0xC40000, ahk_id %this_id%
	Winset, Alwaysontop, , ahk_id %this_id%
	WinHide, ahk_id %this_id%
    WinShow, ahk_id %this_id%
    }
	return
	
Undo:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^z
	return

Redo:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^y
	return
	
ArtResize:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send {Shift Down}
	sleep 1500
	Send {Shift Up}
	return
	
ArtFlip:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	GetKeyState, state, h
	if state = D
		Send {h up}
	else
		Send {h down}
	return
	
ArtPick:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send {LAlt Down}
	sleep 1500
	Send {LAlt Up}
	return
	
ArtTransform:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^!+t
	return
	
ArtWarp:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^w
	return
	
ArtCanvasFlip:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send,^!l
	Send,h
	Send,{Enter}
	return
	
ArtBrushSize:
	Gui, Submit, NoHide
	GuiControl,,UpDownLabel,%MyUpDown%
	return
	
ArtSmaller:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Gui, Submit, NoHide
	Send {[ %MyUpDown%}
	return
	
ArtBigger:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Gui, Submit, NoHide
	Send {] %MyUpDown%}
	return
	
ArtDeselect:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^d
	return
	
ArtClearLayer:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^+c
	return
	
ArtCanvasMove:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send {Space Down}
	sleep 1500
	Send {Space Up}
	return
	
ArtCanvasZoom:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
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
	
ArtCut:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^x
	return
	
ArtPaste:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^v
	return
	
ArtCopy:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^c
	return
	
MyTransparency:
	Gui, Submit, NoHide
	WinSet, Transparent, %MyTransparency%, ArtRageTool
	return
	
ArtMergeDown:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^!{Down}
	return
	
ArtColour:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^j
	return
	
ArtTest:
	WinRestore, ahk_exe %ArtName%.exe
	WinActivate, ahk_exe %ArtName%.exe
	Send ^o
	WinRestore, ahk_class ToolWindow
	Gui, Submit, NoHide
	Send %MyTransparent%, {Enter}
	return

	


