let inputProcesses
let queue = []
let active
const RRN = document.querySelector("#rrInput") || 2
let maxSteps = 0
let uniqueNames
let GANTT = []
let currentQ = 0
let delay = 1 //in seconds
let step
document
  .querySelector("#delayTimeInput")
  .addEventListener(
    "input",
    e =>
      !isNaN(e.target.value) ? (delay = Number(e.target.value)) : (delay = 1)
  )
document
  .querySelector("#rrInput")
  .addEventListener(
    "input",
    e => (!isNaN(e.target.value) ? (RRN = Number(e.target.value)) : (RRN = 2))
  )

const chartList = document.querySelector("#chartList")

document.forms["myform"].elements["myfile"].addEventListener("change", addItem)

function addItem(e) {
  if (!window.FileReader) return // Browser is not compatible

  let reader = new FileReader()

  reader.onload = function(e) {
    if (e.target.readyState != 2) return
    if (e.target.error) {
      alert("Error while reading file")
      return
    }

    filecontent = e.target.result

    let a = filecontent.split("\n").filter(item => item !== "")
    a = a.splice(1, a.length - 1)

    let c = []
    const alphabet = [
      "Z",
      "Y",
      "X",
      "W",
      "V",
      "U",
      "T",
      "S",
      "R",
      "Q",
      "P",
      "O",
      "N",
      "M",
      "L",
      "K",
      "J",
      "I",
      "H",
      "G",
      "F",
      "E",
      "D",
      "C",
      "B",
      "A"
    ]
    let input = []
    const b = a.map(key => {
      let temp = key.split(" ")
      let temp2 = {}

      for (let i in temp) {
        if (Number(i) === 0) {
          temp2.Arrival = Number(temp[i])
        } else if (Number(i) === 1) {
          temp2.Priority = Number(temp[i])
        } else if (Number(i) === 2) {
          temp2.Burst = Number(temp[i])
        }
      }
      temp2.Name = alphabet.pop()

      input.push(temp2)
    })

    console.log(input)
    const inputDisplayContainer = document.querySelector(
      ".inputDisplayContainer"
    )

    inputDisplayContainer.innerHTML = input
      .map(item => {
        console.log(item)
        return `<li>
                  <ul>
                    <label for="item${item.Name}">${item.Name}</label>
                    <li>Arrival: ${item.Arrival}</li>
                    <li>Priority: ${item.Priority}</li>
                    <li>Burst: ${item.Burst}</li>
                  </ul>
                </li>`
      })
      .join("")
    inputProcesses = input
    runGanttProgram()
  }

  reader.readAsText(e.target.files[0])
}

function runGanttProgram() {
  console.log("%cInput Processes", "color:green", inputProcesses)
  console.log("%cDelay", "color:goldenrod", delay)

  // sort input by arrival
  inputProcesses = inputProcesses.sort(
    (a, b) => (a.Arrival > b.Arrival ? 1 : -1)
  )
  step = inputProcesses[0].Arrival

  console.log("%cSorted Input Processes", "color:yellow", inputProcesses)

  /**
   * Get total steps
   */
  getTotalSteps()
  // Begin Event loop where step starts at first item's arrival

  eventLoop()
  // End Event Loop
}
/**
 * Returns whether we're done looping or not
 * @returns {boolean}
 */
function isDone() {
  return queue.length === 0 && getMaxSteps() === 0
}
/**
 * Get total steps it takes to finish
 * @returns {int}
 */
function getMaxSteps() {
  let totalSteps = 0
  for (i of inputProcesses) {
    totalSteps += i.Burst
  }
  return totalSteps
}

/**
 * Get total steps
 * @returns {int}
 */
function getTotalSteps() {
  for (i of inputProcesses) {
    maxSteps += i.Burst
  }
  let arrivalMax = inputProcesses[inputProcesses.length - 1].Arrival
  for (i = inputProcesses.length - 2; i >= 0; i--) {
    arrivalMax -= inputProcesses[i].Arrival
  }
  arrivalMax > 0 ? (arrivalMax = arrivalMax) : (arrivalMax = 1)
  // in case the arrival of the first isn't right at zero, add it's arrival time to max-steps
  maxSteps = maxSteps + inputProcesses[0].Arrival + arrivalMax
}

function eventLoop(i) {
  setTimeout(() => {
    // sort queue backwards by priority
    queue = queue.sort((a, b) => (a.Priority > b.Priority ? -1 : 1))

    for (const i of inputProcesses) {
      // check if arrival == step
      if (i.Arrival === step) {
        console.log(`Process ${i.Name} now in queue`)
        // Push into queue
        queue.push(i)

        // sort queue backwards by priority
        queue = queue.sort((a, b) => (a.Priority > b.Priority ? -1 : 1))
      }
    }

    // make sure there's something in active
    if (active == null) {
      console.log("active is null")
      active = queue[queue.length - 1]
      queue.pop()
    }

    // ALWAYS make sure active is the one with highest priority
    if (active != null && queue.length > 0) {
      if (active.Priority > queue[queue.length - 1].Priority) {
        queue.push(active)
        queue = queue.sort((a, b) => (a.Priority > b.Priority ? -1 : 1))
        active = queue[queue.length - 1]
        queue.pop()
      }
      // if priority is equal, do round robin
      if (active.Priority === queue[queue.length - 1].Priority) {
        if (currentQ < RRN) {
          currentQ++
        } else {
          currentQ = 1
          queue = queue.sort((a, b) => (a.Priority > b.Priority ? -1 : 1))

          let temp = queue[queue.length - 1]
          queue.pop()
          queue.push(active)
          active = temp
        }
      }
    }
    if (active.Burst <= 0) {
      // decrement active or place next item into queue or finish queue
      console.log(`${active.Name} finished burst`)
      active = queue[queue.length - 1]
      queue.pop()
    } else {
      active.Burst--
      // push into the list
      GANTT.push(active.Name)
      chartList.innerHTML = GANTT.toString()
    }

    console.log("%cGantt 📊:", "color:purple", GANTT)
    step++
    console.log("%cAre we done?", "color:orange", isDone())
    if (!isDone()) eventLoop() //  decrement i and call myLoop again if i > 0
  }, delay * 1000)
}
