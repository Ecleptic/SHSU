import turtle

# Named constants
STARTING_X = -4
STARTING_Y = 4
STARTING_SIZE = 8
NUM_SQUARES = 50
STEP = 2
NUM_SIDES = 4
ANGLE = 90
ANIMATION_SPEED = 0

turtle.speed(ANIMATION_SPEED)
turtle.hideturtle()

x = STARTING_X
y = STARTING_Y
size = STARTING_SIZE

for count in range(2, 50, 2):
    # Position the turtle.
    turtle.penup()
    turtle.goto(x, y)
    turtle.pendown()
    
    # Draw the square
    for s in range(NUM_SIDES):
        turtle.forward(size)
        turtle.right(ANGLE)

    # Prepare for the next square.
    x = x - 2
    y = y + 2
    size = size + 4
