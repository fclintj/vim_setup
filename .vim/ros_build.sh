#!/bin/bash
path=${1%/*}

while [[ $path != $HOME && $path != \/ && $path != \/home ]]; do
    if [[ -d "$path/src" && -d "$path/devel" && "$path/build" ]]; then
        catkin_make -C $path
        source $path/devel/setup.bash

        # run launch file if available 
        for i in $(<$path/params); do 
            output+=" $i"
        done 2>/dev/null

        if [[ $output != "" ]]; then
            clear
            # print running title
            echo  "-------- Running --------"
            $output
        fi
        exit 0
    fi
    path=${path%/*}
done

echo To build ROS, navigate to a folder or subfolder with:
echo 
echo -e '   build, devel, src'
echo
