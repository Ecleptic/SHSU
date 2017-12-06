import turtle

# Named constants
SCREEN_WIDTH = 600
SCREEN_HEIGHT = 600
BULLSEYE_RADIUS = 25
RING1_RADIUS = 300
RING2_RADIUS = 200
RING3_RADIUS = 100

# Set the graphics window size.
turtle.setup(SCREEN_WIDTH, SCREEN_HEIGHT)
turtle.speed(0)
turtle.hideturtle()

# Draw ring 1.
turtle.penup()
turtle.goto(0, -RING1_RADIUS)
turtle.fillcolor('black')
turtle.pendown()
turtle.begin_fill()
turtle.circle(RING1_RADIUS)
turtle.end_fill()

# Draw ring 2.
turtle.penup()
turtle.goto(0, -RING2_RADIUS)
turtle.fillcolor('white')
turtle.pendown()
turtle.begin_fill()
turtle.circle(RING2_RADIUS)
turtle.end_fill()

# Draw ring 3.
turtle.penup()
turtle.goto(0, -RING3_RADIUS)
turtle.fillcolor('black')
turtle.pendown()
turtle.begin_fill()
turtle.circle(RING3_RADIUS)
turtle.end_fill()

# Draw the bullseye.
turtle.penup()
turtle.goto(0, -BULLSEYE_RADIUS)
turtle.fillcolor('red')
turtle.pendown()
turtle.begin_fill()
turtle.circle(BULLSEYE_RADIUS)
turtle.end_fill()

# Get the amount of force to throw the dart.
print('Welcome to the game of darts.')
print('How many feet away from the target are you standing?')
distance = int(input('Minimum = 6, maximum = 12: '))
print('How much force will you use to throw the dart?')
force = int(input('Minimum = 1, maximum = 50: '))



