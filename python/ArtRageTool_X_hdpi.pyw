import tkinter as tk
import tkinter.font as tkFont
import pyautogui
import time

clickx=1910
clicky=1070

class App:
    def __init__(self, root):
#        tk.Tk.__init__(self)
        var = tk.IntVar()
        tk.Tk.withdraw(root)
        root.floater = FloatingWindow(root)

class FloatingWindow(tk.Toplevel):
    def __init__(self, *args, **kwargs):
        tk.Toplevel.__init__(self, *args, **kwargs)
        fg="#dddddd"
        bg="#444444"
        relief="solid"
        bw=50
        bh=40
        bp=6
        topl=15
        cols=7
        rows=2
        # initial position
        bxc=bp
        byc=bp
        width=(cols*bw)+((cols+1)*bp)
        height=(rows*bh)+((rows+2)*bp)+topl
        alignstr = '%dx%d+%d+%d' % (width, height, 1000, 100)
        self.geometry(alignstr)
        self.attributes('-topmost',True)
        self.attributes('-alpha',0.5)
        self.config(bg=bg)
        self.overrideredirect(True)

        self.grip = tk.Label(self)
        self.grip["bg"] = bg
        self.grip.place(x=bxc,y=byc,width=((cols-1)*bw)+(cols*bp),height=topl)
        
        self.grip.bind("<ButtonPress-1>", self.start_move)
        self.grip.bind("<ButtonRelease-1>", self.stop_move)
        self.grip.bind("<B1-Motion>", self.do_move)

        fontsize=int(bw/5)
        ft = tkFont.Font(family='Helvetica',size=fontsize)
                
        bxc=((cols-1)*bw)+(cols*bp)
        GButton_862=tk.Button(self)
        GButton_862["bg"] = bg
        GButton_862["font"] = ft
        GButton_862["fg"] = fg
        GButton_862["text"] = "x"
        GButton_862["relief"] = relief
        GButton_862.place(x=bxc,y=byc,width=bw,height=topl)
        GButton_862["command"] = root.quit

        byc+=topl+bp
        bxc=bp
        GButton_861=tk.Button(self)
        GButton_861["bg"] = bg
        GButton_861["font"] = ft
        GButton_861["fg"] = fg
        GButton_861["text"] = "<"
        GButton_861["relief"] = relief
        GButton_861.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_861["command"] = self.GButton_undo_command

        bxc+=bw+bp
        GButton_729=tk.Button(self)
        GButton_729["bg"] = bg
        GButton_729["font"] = ft
        GButton_729["fg"] = fg
        GButton_729["text"] = ">"
        GButton_729["relief"] = relief
        GButton_729.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_729["command"] = self.GButton_redo_command
                
        bxc+=bw+bp
        GButton_914=tk.Button(self)
        GButton_914["bg"] = bg
        GButton_914["font"] = ft
        GButton_914["fg"] = fg
        GButton_914["text"] = "C"
        GButton_914["relief"] = relief
        GButton_914.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_914["command"] = self.GButton_color_command
        
        bxc+=bw+bp
        GCheckBox_117=tk.Checkbutton(self, text='', variable=var)
        GCheckBox_117["bg"] = bg
        GCheckBox_117["font"] = ft
        GCheckBox_117["fg"] = "#333333"
        GCheckBox_117["text"] = ""
        GCheckBox_117["relief"] = relief
        GCheckBox_117.place(x=bxc,y=byc,width=bw,height=bh)
        GCheckBox_117["offvalue"] = "0"
        GCheckBox_117["onvalue"] = "1"
        GCheckBox_117["command"] = self.GCheckBox_flip_command

        bxc+=bw+bp
        GButton_251=tk.Button(self)
        GButton_251["bg"] = bg
        GButton_251["font"] = ft
        GButton_251["fg"] = fg
        GButton_251["text"] = "Z"
        GButton_251["relief"] = relief
        GButton_251.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_251["command"] = self.GButton_zoom_command

        bxc+=bw+bp
        GButton_251=tk.Button(self)
        GButton_251["bg"] = bg
        GButton_251["font"] = ft
        GButton_251["fg"] = fg
        GButton_251["text"] = "Q"
        GButton_251["relief"] = relief
        GButton_251.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_251["command"] = self.GButton_quit_command

        bxc+=bw+bp
        GButton_251=tk.Button(self)
        GButton_251["bg"] = bg
        GButton_251["font"] = ft
        GButton_251["fg"] = fg
        GButton_251["text"] = "S"
        GButton_251["relief"] = relief
        GButton_251.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_251["command"] = self.GButton_save_command

        # Line 2
        byc+=bh+bp
        bxc=bp
        GButton_822=tk.Button(self)
        GButton_822["bg"] = bg
        GButton_822["font"] = ft
        GButton_822["fg"] = fg
        GButton_822["text"] = "Shift"
        GButton_822["relief"] = relief
        GButton_822.place(x=bxc,y=byc,width=(bw*2)+bp,height=bh)
        GButton_822["command"] = self.GButton_shift_command

        bxc+=(bw*2)+(bp*2)
        GButton_440=tk.Button(self)
        GButton_440["bg"] = bg
        GButton_440["font"] = ft
        GButton_440["fg"] = fg
        GButton_440["text"] = "Ctrl"
        GButton_440["relief"] = relief
        GButton_440.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_440["command"] = self.GButton_ctrl_command

        bxc+=bw+bp
        GButton_440=tk.Button(self)
        GButton_440["bg"] = bg
        GButton_440["font"] = ft
        GButton_440["fg"] = fg
        GButton_440["text"] = "Alt"
        GButton_440["relief"] = relief
        GButton_440.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_440["command"] = self.GButton_alt_command

        bxc+=bw+bp
        GButton_346=tk.Button(self)
        GButton_346["bg"] = bg
        GButton_346["font"] = ft
        GButton_346["fg"] = fg
        GButton_346["text"] = "M"
        GButton_346["relief"] = relief
        GButton_346.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_346["command"] = self.GButton_move_command
        
        bxc+=bw+bp
        GButton_346=tk.Button(self)
        GButton_346["bg"] = bg
        GButton_346["font"] = ft
        GButton_346["fg"] = fg
        GButton_346["text"] = "E"
        GButton_346["relief"] = relief
        GButton_346.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_346["command"] = self.GButton_enter_command

        bxc+=bw+bp
        GButton_346=tk.Button(self)
        GButton_346["bg"] = bg
        GButton_346["font"] = ft
        GButton_346["fg"] = fg
        GButton_346["text"] = "O"
        GButton_346["relief"] = relief
        GButton_346.place(x=bxc,y=byc,width=bw,height=bh)
        GButton_346["command"] = self.GButton_open_command

    def start_move(self, event):
        self.x = event.x
        self.y = event.y

    def stop_move(self, event):
        self.x = None
        self.y = None

    def do_move(self, event):
        deltax = event.x - self.x
        deltay = event.y - self.y
        x = self.winfo_x() + deltax
        y = self.winfo_y() + deltay
        self.geometry(f"+{x}+{y}")

    def GButton_undo_command(self):
        print("<")
        pyautogui.click(clickx,clicky)
        pyautogui.hotkey('ctrl', 'z')
        
    def GButton_redo_command(self):
        print(">")
        pyautogui.click(clickx,clicky)
        pyautogui.hotkey('ctrl', 'y')
        
    def GButton_color_command(self):
        print("C")
        pyautogui.click(clickx,clicky)
        pyautogui.hotkey('ctrl', 'shift', "c")

    def GCheckBox_flip_command(self):
        print("Flip")
        pyautogui.click(clickx,clicky)

        if var.get() == 1:
            print(1)
            pyautogui.keyDown('h')
        else:
            print(0)
            pyautogui.keyUp('h')
        
    def GButton_zoom_command(self):
        print("Z")
        pyautogui.click(clickx,clicky)
        pyautogui.keyDown('space')
        pyautogui.keyDown('ctrl')
        time.sleep(1.5)
        pyautogui.keyUp('space')
        pyautogui.keyUp('ctrl')

    def GButton_save_command(self):
        print("Save")
        pyautogui.click(clickx,clicky)
        pyautogui.hotkey('ctrl', 's')
        time.sleep(0.5)
        pyautogui.press('enter')

    def GButton_quit_command(self):
        print("Quit")
        pyautogui.click(clickx,clicky)
        pyautogui.hotkey('ctrl', 'q')
        time.sleep(0.5)
        pyautogui.hotkey('ctrl', 'd')

    def GButton_shift_command(self):
        print("Shift")
        pyautogui.click(clickx,clicky)
        pyautogui.keyDown('shift')
        time.sleep(1.5)
        pyautogui.keyUp('shift')

    def GButton_deselect_command(self):
        print("Des")
        pyautogui.click(clickx,clicky)
        pyautogui.hotkey('ctrl', 'd')

    def GButton_alt_command(self):
        print("Alt")
        pyautogui.click(clickx,clicky)
        pyautogui.keyDown('alt')
        time.sleep(1.5)
        pyautogui.keyUp('alt')

    def GButton_move_command(self):
        print("M")
        pyautogui.click(clickx,clicky)
        pyautogui.keyDown('space')
        time.sleep(1.5)
        pyautogui.keyUp('space')

    def GButton_ctrl_command(self):
        print("ctrl")
        pyautogui.click(clickx,clicky)
        pyautogui.keyDown('ctrl')
        time.sleep(1.5)
        pyautogui.keyUp('ctrl')

    def GButton_enter_command(self):
        print("enter")
        pyautogui.click(clickx,clicky)
        pyautogui.press('enter')

    def GButton_open_command(self):
        print("open")
        pyautogui.click(clickx,clicky)
        pyautogui.hotkey('ctrl', 'o')

if __name__ == "__main__":
    root = tk.Tk()
    var = tk.IntVar()
    app=App(root)
    root.mainloop()
