# Simple To Do List GUI by Christian Thompson (@tokyoedtech)
# Python 2.7
# Part 6: messagebox
import tkinter
from tkinter import messagebox
import redis
import ast



# Create app window
app = tkinter.Tk()

# Change app window background color
app.configure(bg="white")

# Change the title
app.title("To-Do List")

# Change the window size
app.geometry("325x275")

# Create an empty list
tasks = []


# r = redis.StrictRedis(host='localhost', port=6379, db=0,
#                       charset="utf-8", decode_responses=True)
# r.set('foo', 'bar')
# print(r.get('foo'))
# tasks = r.get('tasks')
# tasks = ast.literal_eval(tasks)
# print ((tasks))
# For testing purposes use a default list
tasks = ["Call mom", "Buy a lootbox", "Eat a Burger"]
# Create functions


def update_listbox():
    clear_listbox()
    for task in tasks:
        todoListRoot.insert("end", task)


def clear_listbox():
    todoListRoot.delete(0, "end")


def add_task():
    task = textInput.get()
    if task != "":  # if not empty
        tasks.append(task)
        update_listbox()
    else:
        messagebox.showwarning("Warning", "Please enter a todo")
    textInput.delete(0, "end")


def del_all():
    confirmed = messagebox.askyesno(
        "Please Confirm", "Do you really want to delete all?")
    if confirmed == True:
        global tasks  # needs to edit tasks, not just read it
        tasks = []
        update_listbox()


def del_one():
    task = todoListRoot.get("active")
    if task in tasks:  # Confirm in the list
        tasks.remove(task)
    update_listbox()


def sort_asc():
    tasks.sort()
    update_listbox()


def show_number_of_tasks():
    number_of_tasks = len(tasks)
    msg = "Number of tasks: %s" % number_of_tasks
    labelDisplayText["text"] = msg


def init():
    sort_asc()
    print('hi there')


def exitApp():
    print('closing')
    r.set('tasks', tasks)

    app.quit()


labelTitleText = tkinter.Label(app, text="To-Do-List", bg="white")
labelTitleText.grid(row=0, column=0)

labelDisplayText = tkinter.Label(app, text="", bg="white")
labelDisplayText.grid(row=0, column=1)

textInput = tkinter.Entry(app, width=15)
textInput.grid(row=1, column=1)

addTaskButton = tkinter.Button(
    app, text="Add task", fg="green", bg="white", command=add_task)
addTaskButton.grid(row=1, column=0)

deleteAllButton = tkinter.Button(
    app, text="Delete All", fg="green", bg="white", command=del_all)
deleteAllButton.grid(row=2, column=0)

deleteOneButton = tkinter.Button(
    app, text="Delete", fg="green", bg="white", command=del_one)
deleteOneButton.grid(row=3, column=0)

sortAscendingButton = tkinter.Button(
    app, text="Sort (ASC)", fg="green", bg="white", command=sort_asc)
sortAscendingButton.grid(row=4, column=0)

numberTasksButton = tkinter.Button(
    app, text="Number of Tasks", fg="green", bg="white", command=show_number_of_tasks)
numberTasksButton.grid(row=7, column=0)

exitButton = tkinter.Button(
    app, text="Exit", fg="green", bg="white", command=exitApp)
exitButton.grid(row=8, column=0)

todoListRoot = tkinter.Listbox(app)
todoListRoot.grid(row=2, column=1, rowspan=17)

app.after_idle(init)
# Start the main events loop
app.mainloop()
