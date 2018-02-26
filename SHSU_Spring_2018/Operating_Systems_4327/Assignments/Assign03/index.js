document.forms["myform"].elements["myfile"].onchange = function(evt) {
  if (!window.FileReader) return // Browser is not compatible

  var reader = new FileReader()

  reader.onload = function(evt) {
    if (evt.target.readyState != 2) return
    if (evt.target.error) {
      alert("Error while reading file")
      return
    }

    filecontent = evt.target.result

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

      for (i in temp) {
        if (i == 0) {
          temp2.Arrival = temp[i]
        } else if (i == 1) {
          temp2.Priority = temp[i]
        } else if (i == 2) {
          temp2.Burst = temp[i]
        }
      }
      temp2.Name = alphabet.pop()

      input.push(temp2)
    })

    console.log(input)
    document.forms["myform"].elements["text"].value = JSON.stringify(input)
  }

  reader.readAsText(evt.target.files[0])
}
