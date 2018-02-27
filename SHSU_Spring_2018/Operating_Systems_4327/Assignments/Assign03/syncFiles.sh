#!/bin/bash
# sync directories
result=${PWD##*/}          #  assign currrent directory to a variable
if [ $result == 'Assign03' ]
then
    echo "Pushing Changes to Projects folder"
    rsync -azvh ~/Documents/SHSU\ 👾\ /SHSU_Spring_2018/Operating_Systems_4327/Assignments/Assign03/. ~/Documents/Projects\ 💩\ 👻\ /GANTT_Chart/.
elif [ $result == 'GANTT_Chart' ]
then
    echo "Pushing Changes to SHSU folder"
    rsync -azvh ~/Documents/Projects\ 💩\ 👻\ /GANTT_Chart/.  ~/Documents/SHSU\ 👾\ /SHSU_Spring_2018/Operating_Systems_4327/Assignments/Assign03/.
else
    echo "whoops, wrong directory"
fi

# printf '%s\n' "${PWD##*/}"

