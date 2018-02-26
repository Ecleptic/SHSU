
let inputProcesses = [
  {
    Name: "A",
    Arrival: 10,
    Priority: 5,
    Burst: 8
  },
  {
    Name: "B",
    Arrival: 12,
    Priority: 8,
    Burst: 12
  },
  {
    Name: "C",
    Arrival: 4,
    Priority: 2,
    Burst: 7
  },
  {
    Name: "D",
    Arrival: 8,
    Priority: 2,
    Burst: 9
  }
]
let queue = []
let active
const RRN = 2
let maxSteps = 0
let uniqueNames
let GANTT = []
let currentQ = 0

// sort input by arrival
inputProcesses = inputProcesses.sort((a, b) => (a.Arrival > b.Arrival ? 1 : -1))

//get total steps
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

// Begin Event loop where step starts at first item's arrival

// for (let step = inputProcesses[0].Arrival; step <= maxSteps; step++) {
let step = inputProcesses[0].Arrival
while (!isDone()) {
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
  }

  // check if there's anywhere left to go.

  console.log(GANTT)
  step++
}
// End Event Loop

function isDone() {
  return queue.length === 0 && getMaxSteps() === 0
}
/**
 * Get total steps
 */
function getMaxSteps() {
  let totalSteps = 0
  for (i of inputProcesses) {
    totalSteps += i.Burst
  }
  return totalSteps
}
