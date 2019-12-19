#!/bin/bash

for (( i=1; i<=18; i++ ))
do
    if ((i % 10 == $i)); then
        group_number="0$i"
    else
        group_number=$i
    fi

    # url="git@gitlab.informatika.org:if3110-2019-01-k01-$group_number/tugas-besar-1-2019.git"
    url="https://gitlab.informatika.org/if3110-2019-01-k01-$group_number/tugas-besar-1-2019.git"
    output_path="$1/$group_number"
    git clone $url $output_path
done