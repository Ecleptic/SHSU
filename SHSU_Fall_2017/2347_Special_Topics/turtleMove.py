import turtle
# name turtle
silly = turtle.Turtle()

# setup the window co-ordinates
turtle.setup(640, 800)
# show turtle
silly.showturtle()
# set the turtle's angle
silly.right(90)
silly.setheading(90)
# move turtle forward and backward
silly.forward(100)
silly.backward(50)
# penup and pen down
silly.penup()
# draw a non-continuous line
silly.forward(25)
silly.pendown()
# size of circle
silly.circle(50)

turtle.pensize(5)
turtle.pencolor('red')

# returns location x and why
turtle.pos()
turtle.xcor()
turtle.ycor()

# write turtle
turtle.write('hello', move=True, align='right', font=('Arial'20, normal))

turtle.fillcolor('red')
turtle.done()
