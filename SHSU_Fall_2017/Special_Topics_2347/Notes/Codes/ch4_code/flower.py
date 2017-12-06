# This program draws a design using repeated circles.
import turtle

# Named constants
NUM_CIRCLES = 36    # Number of circles to draw
RADIUS = 25         # Radius of each circle
ANGLE = 10          # Angle to turn
ANIMATION_SPEED = 0 # Animation speed

# Set the animation speed.
turtle.speed(ANIMATION_SPEED)

# Draw the center of the flower as 36 circles, with the
# turtle tilted by 10 degrees after each circle is drawn.
for x in range(NUM_CIRCLES):
    turtle.circle(RADIUS)
    turtle.left(ANGLE)

# Reposition the turtle.
turtle.penup()
turtle.goto(0,0)
turtle.setheading(0)

# Draw the petals.
for x in range(36):
    turtle.forward(RADIUS * 2)
    turtle.pendown()
    turtle.left(25)
    turtle.forward(100)
    turtle.right(90)
    turtle.forward(100)
    turtle.right(90)
    turtle.forward(100)
    turtle.right(90)
    turtle.forward(100)
    turtle.penup()
    turtle.goto(0,0)
    turtle.left(10)
