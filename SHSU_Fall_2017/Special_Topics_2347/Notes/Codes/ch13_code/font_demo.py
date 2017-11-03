# This program draws text on a Canvas.
import tkinter
import tkinter.font

class MyGUI:
    def __init__(self):
        # Create the main window.
        self.main_window = tkinter.Tk()

        # Create the Canvas widget.
        self.canvas = tkinter.Canvas(self.main_window, width=200, height=200)

        # Create a Font object.
        myfont = tkinter.font.Font(family='Helvetica', size=18, weight='bold')

        # Display some text.
        self.canvas.create_text(100, 100, text='Hello World', font=myfont)
        
        # Pack the canvas.
        self.canvas.pack()
        
        # Start the mainloop.
        tkinter.mainloop()

# Create an instance of the MyGUI class.
my_gui = MyGUI()
