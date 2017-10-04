import turtle

moveLength = 50

def drawFilledSquare():
    turtle.pendown()
    turtle.begin_fill()
    for i in range(4):
        turtle.forward(moveLength)
        turtle.right(90)
    turtle.end_fill()

def drawEmptySquare():
    turtle.pendown()
    for i in range(4):
        turtle.forward(moveLength)
        turtle.right(90)


def goLeftColumn():
    turtle.penup()
    turtle.setheading(180)
    turtle.forward(moveLength * 8)

    turtle.setheading(90)
    turtle.forward(moveLength)
    turtle.setheading(0)

turtle.showturtle()

# SETUP TABLE
turtle.setup(800, 800)
turtle.speed(0)
turtle.penup()
turtle.setheading(-90)
turtle.forward(200)
turtle.setheading(-180)
turtle.forward(200)
turtle.setheading(0)

for j in range(4):
    for i in range(4):
        drawFilledSquare()
        turtle.forward(moveLength)
        drawEmptySquare()
        turtle.forward(moveLength)
    goLeftColumn()
    for i in range(4):
        drawEmptySquare()
        turtle.forward(moveLength)
        drawFilledSquare()
        turtle.forward(moveLength)
    goLeftColumn()

turtle.ht()
turtle.done()
