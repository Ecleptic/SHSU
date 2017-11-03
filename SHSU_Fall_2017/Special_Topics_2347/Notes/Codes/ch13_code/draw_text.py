# This program draws text on a Canvas.
import tkinter

class MyGUI:
    def __init__(self):
        # Create the main window.
        self.main_window = tkinter.Tk()

        # Create the Canvas widget.
        self.canvas = tkinter.Canvas(self.main_window, width=200, height=200)

        # Display text in the center of the window.
        self.canvas.create_text(100, 100, text='Hello World')
        
        # Pack the canvas.
        self.canvas.pack()
        
        # Start the mainloop.
        tkinter.mainloop()

# Create an instance of the MyGUI class.
my_gui = MyGUI()
