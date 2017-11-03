# This program draws a pie chart on a Canvas.
import tkinter

class MyGUI:
    def __init__(self):
        self.__CANVAS_WIDTH = 320  # Canvas width
        self.__CANVAS_HEIGHT = 240 # Canvas height
        self.__X1 = 60             # Upper-left X of bounding rectangle
        self.__Y1 = 20             # Upper-left Y of bounding rectangle
        self.__X2 = 260            # Lower-right X of bounding rectangle
        self.__Y2 = 220            # Lower-right Y of bounding rectangle
        self.__PIE1_START = 0      # Starting angle of slice 1
        self.__PIE1_WIDTH = 45     # Extent of slice 1
        self.__PIE2_START = 45     # Starting angle of slice 2
        self.__PIE2_WIDTH = 90     # Extent of slice 2
        self.__PIE3_START = 135    # Starting angle of slice 3
        self.__PIE3_WIDTH = 120    # Extent of slice 3
        self.__PIE4_START = 255    # Starting angle of slice 4
        self.__PIE4_WIDTH = 105    # Extent of slice 4
        
        # Create the main window.
        self.main_window = tkinter.Tk()

        # Create the Canvas widget.
        self.canvas = tkinter.Canvas(self.main_window,
                                     width=self.__CANVAS_WIDTH,
                                     height=self.__CANVAS_HEIGHT)

        # Draw slice 1.
        self.canvas.create_arc(self.__X1, self.__Y1, self.__X2, self.__Y2,
                               start=self.__PIE1_START,
                               extent=self.__PIE1_WIDTH,
                               fill='red')

        # Draw slice 2.
        self.canvas.create_arc(self.__X1, self.__Y1, self.__X2, self.__Y2,
                               start=self.__PIE2_START,
                               extent=self.__PIE2_WIDTH,
                               fill='green')

        # Draw slice 3.
        self.canvas.create_arc(self.__X1, self.__Y1, self.__X2, self.__Y2,
                               start=self.__PIE3_START,
                               extent=self.__PIE3_WIDTH,
                               fill='black')

        # Draw slice 4.
        self.canvas.create_arc(self.__X1, self.__Y1, self.__X2, self.__Y2,
                               start=self.__PIE4_START,
                               extent=self.__PIE4_WIDTH,
                               fill='yellow')
        
        # Pack the canvas.
        self.canvas.pack()
        
        # Start the mainloop.
        tkinter.mainloop()

# Create an instance of the MyGUI class.
my_gui = MyGUI()
