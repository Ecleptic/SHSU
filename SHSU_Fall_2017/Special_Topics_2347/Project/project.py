import tkinter
from tkinter import Frame
from tkinter import messagebox
import redis
import ast

# setup backend
redisClient = redis.StrictRedis(host='localhost', port=6379, db=0,
                      charset="utf-8", decode_responses=True)

class app(Frame):
    def __init__(self,master = None):
        Frame.__init__(self,master)
        self.master=master

# functions:

def updateBox():
    clearBox()
    for task in tasks:
        todoListApp.insert("end", task)


def clearBox():
    todoListApp.delete(0, "end")


def addTask():
    task = textInput.get()
    if task != "":  # if not empty
        tasks.append(task)
        redisClient.set('tasks', tasks)

        updateBox()
    else:
        messagebox.showwarning("Warning", "Please enter a todo")
    textInput.delete(0, "end")


def deleteAll():
    confirmed = messagebox.askyesno(
        "Please Confirm", "Do you really want to delete all?")
    if confirmed == True:
        global tasks  # needs to edit tasks, not just read it
        tasks = []
        updateBox()


def delete():
    task = todoListApp.get("active")
    if task in tasks:  # Confirm in the list
        tasks.remove(task)

    redisClient.set('tasks', tasks)
    updateBox()


def sort():
    tasks.sort()
    updateBox()


# def show_number_of_tasks():
#     number_of_tasks = len(tasks)
#     msg = "Number of tasks: %s" % number_of_tasks
#     labelDisplayText["text"] = msg


def init():
    sort()
    print('hi there')


def exitApp():
    print('closing')
    redisClient.set('tasks', tasks)
    app.quit()


tasks = [] ## just in case redis breaks

tasks = redisClient.get('tasks')
tasks = ast.literal_eval(tasks)
print (tasks)




class Window(Frame):
    def __init__(self,master = None):
        Frame.__init__(self,master)
        self.master=master


app = tkinter.Tk()
app.title("Todo List")

lableTitleText = tkinter.Label(app, text="ToDo List", bg="orange",fg="black").grid(row=0,column=0)

# Button to add tasks
addTaskButton = tkinter.Button(app, text="Add task", fg="green", bg="white", command=addTask)
addTaskButton.grid(row=1,column=0)

deleteButton = tkinter.Button(
    app, text="Delete", fg="green", bg="white", command=delete)
deleteButton.grid(row=3, column=0)


textInput=tkinter.Entry(app,width=20,bg="white")
textInput.grid(row=4,column=0)


todoListApp = tkinter.Listbox(app)
todoListApp.grid(row=5, column=0, rowspan=20)


exitButton = tkinter.Button(
    app, text="Exit", fg="green", bg="white", command=exitApp)
exitButton.grid(row=25, column=0)


app = Window(app)
app.after_idle(init)
app.mainloop()