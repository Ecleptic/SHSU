# This program demonstrates the different text anchors.
import tkinter
import tkinter.font

class MyGUI:
    def __init__(self):
        # Create the main window.
        self.main_window = tkinter.Tk()

        # Create font object.
        myfont = tkinter.font.Font(family='Helvetica', size=12)

        # Create the Canvas widget.
        self.canvas = tkinter.Canvas(self.main_window, width=400, height=380)

        # Display text using the various anchor values.
        self.draw_dot(200, 20)
        self.canvas.create_text(200, 20, text='This text uses tkinter.CENTER', anchor=tkinter.CENTER, font=myfont)

        self.draw_dot(200, 60)
        self.canvas.create_text(200, 60, text='This text uses tkinter.NW', anchor=tkinter.NW, font=myfont)

        self.draw_dot(200, 100)
        self.canvas.create_text(200, 100, text='This text uses tkinter.N', anchor=tkinter.N, font=myfont)

        self.draw_dot(200, 140)
        self.canvas.create_text(200, 140, text='This text uses tkinter.NE', anchor=tkinter.NE, font=myfont)

        self.draw_dot(200, 180)
        self.canvas.create_text(200, 180, text='This text uses tkinter.W', anchor=tkinter.W, font=myfont)

        self.draw_dot(200, 220)
        self.canvas.create_text(200, 220, text='This text uses tkinter.E', anchor=tkinter.E, font=myfont)

        self.draw_dot(200, 260)
        self.canvas.create_text(200, 260, text='This text uses tkinter.SW', anchor=tkinter.SW, font=myfont)

        self.draw_dot(200, 300)
        self.canvas.create_text(200, 300, text='This text uses tkinter.S', anchor=tkinter.S, font=myfont)

        self.draw_dot(200, 340)
        self.canvas.create_text(200, 340, text='This text uses tkinter.SE', anchor=tkinter.SE, font=myfont)
        
        # Pack the canvas.
        self.canvas.pack()
        
        # Start the mainloop.
        tkinter.mainloop()

    def draw_dot(self, x, y):
        self.canvas.create_oval(x-3, y-3, x+3, y+3, fill='red')

# Create an instance of the MyGUI class.
my_gui = MyGUI()
