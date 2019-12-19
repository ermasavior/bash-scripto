#!/bin/bash

for (( i=1; i<=18; i++ ))
do
    if ((i % 10 == $i)); then
        group_number="0$i"
    else
        group_number=$i
    fi

    # url="git@gitlab.informatika.org:if3110-2019-02-k01-$group_number/bank-pro.git"
    url="https://gitlab.informatika.org/if3110-2019-02-k01-$group_number/bank-pro.git"
    output_path="$1/$group_number"
    git clone $url $output_path
done