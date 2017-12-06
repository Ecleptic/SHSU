# This program draws a design using repeated squares.
import turtle

# Named constants
NUM_SQUARES = 36    # Number of squares to draw
LINE_LENGTH = 200   # Length of each line
ANGLE_1 = 90        # Angle to turn after each side
ANGLE_2 = 10        # Angle to turn after each square
ANIMATION_SPEED = 0 # Animation speed

# Initialize the turtle.
turtle.speed(ANIMATION_SPEED)
turtle.hideturtle()

# Draw 36 squares, with the turtle tilted
# by 10 degrees after each square is drawn.
for x in range(NUM_SQUARES):
    turtle.forward(LINE_LENGTH)   # First side
    turtle.left(ANGLE_1)
    turtle.forward(LINE_LENGTH)   # Second side
    turtle.left(ANGLE_1)
    turtle.forward(LINE_LENGTH)   # Third side
    turtle.left(ANGLE_1)
    turtle.forward(LINE_LENGTH)   # Fourth side
    turtle.left(ANGLE_1)
    turtle.left(ANGLE_2)          # Angle for next square
