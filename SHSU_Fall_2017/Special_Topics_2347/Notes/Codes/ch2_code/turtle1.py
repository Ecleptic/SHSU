import turtle
# setup the window co-ordinates
turtle.setup(640,800)
# show the turtle
turtle.showturtle()
# set the turtle's angle
turtle.right(90)
turtle.setheading(90)
# Move the turtle forward and backward
turtle.forward(100)
turtle.back(50)
# Penup and Pen down
turtle.penup()
#draw a not continuous line
turtle.forward(25)
turtle.pendown()
turtle.forward(50)
turtle.penup()
turtle.forward(25)
turtle.pendown()
turtle.forward(50)
#draw a circle
turtle.circle(50)
#draw a small dot
turtle.dot()
#draw a dot , specifying the size and the color
turtle.dot(20, "blue"); 
#specifying the size and the color of the line
turtle.pensize(5)
turtle.pencolor('red')
turtle.forward(50)
#Move the turtle to specific position
turtle.goto(0,60)
#Get the turtle's position
turtle.pos()
turtle.xcor()
turtle.ycor()
#Write text
turtle.write('helloooooo')
turtle.write('Rabieh', move = True, align='right',font=('Arial',20, 'normal'))
#filling shapes
turtle.fillcolor('red')
turtle.begin_fill()
turtle.circle(100)
turtle.end_fill()
#Turtle.done to keeep the window open in script mode
turtle.done()