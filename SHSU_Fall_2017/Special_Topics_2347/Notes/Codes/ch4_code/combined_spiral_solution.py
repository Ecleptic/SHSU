# This program draws a design using repeated circles.
import turtle

# Named constants
NUM_CIRCLES = 36      # Number of circles to draw
RADIUS = 25           # Radius of each circle
CIRCLE_ANGLE = 10     # Angle to turn when drawing circles
CIRCLE_START_X = 0    # Starting X coordinate for lines
CIRCLE_START_Y = 0  # Starting Y coordinate for lines
LINE_START_X = -200   # Starting X coordinate for lines
LINE_START_Y = 0      # Starting Y coordinate for lines
NUM_LINES = 36        # Number of lines to draw
LINE_LENGTH = 400     # Length of each line
LINE_ANGLE = 170      # Angle to turn
ANIMATION_SPEED = 0   # Animation speed

# Set the animation speed.
turtle.speed(ANIMATION_SPEED)

# Move the turtle to its initial position to draw the circles.
turtle.hideturtle()
turtle.penup()
turtle.goto(CIRCLE_START_X, CIRCLE_START_Y)
turtle.pendown()

# Draw 36 circles, with the turtle tilted
# by 10 degrees after each circle is drawn.
for x in range(NUM_CIRCLES):
    turtle.circle(RADIUS)
    turtle.left(CIRCLE_ANGLE)

# Move the turtle to its initial position to draw the lines.
turtle.hideturtle()
turtle.penup()
turtle.goto(LINE_START_X, LINE_START_Y)
turtle.pendown()

# Draw 36 lines, with the turtle tilted
# by 170 degrees after each line is drawn.
for x in range(NUM_LINES):
    turtle.forward(LINE_LENGTH)
    turtle.left(LINE_ANGLE)
