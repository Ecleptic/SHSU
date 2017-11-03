# This program draws a polygon on a Canvas.
import tkinter

class MyGUI:
    def __init__(self):
        # Create the main window.
        self.main_window = tkinter.Tk()

        # Create the Canvas widget.
        self.canvas = tkinter.Canvas(self.main_window, width=160, height=160)

        # Draw a polygon.
        self.canvas.create_polygon(60, 20, 100, 20, 140, 60, 140, 100,
                                   100, 140, 60, 140, 20, 100, 20, 60)
        
        # Pack the canvas.
        self.canvas.pack()
        
        # Start the mainloop.
        tkinter.mainloop()

# Create an instance of the MyGUI class.
my_gui = MyGUI()
