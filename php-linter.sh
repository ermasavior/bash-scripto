#!/bin/bash

HOME_DIR=$1/*

count_total_lines() {
    repo_dir=$1
    files=`find $repo_dir -type f -name '*.php'`
    total_lines=0
    for filename in $files; do
        line_count_out=`wc -l $filename`
        line_count="$(cut -d' ' -f1 <<< "$line_count_out")"
        total_lines="$(($total_lines + $line_count))"
    done
    echo $total_lines
}

phpcs_lint() {
    standard=$1
    repo=$2
    error_lines=`phpcs --standard="$standard" --extensions=php -n "$repo" \
                | grep -oP "AFFECTING [0-9]* LINE" | sed -e 's/[^0-9]//g'`

    total_count=0
    for count in $error_lines; do
        total_count="$(($total_count + $count))"
    done

    echo $total_count
}

calculate_percentage() {
    count=$1
    total_lines=$2
    echo `bc -l <<< 1-$count/$total_lines`
}



echo "Repo Path,PSR1,PSR2"

# iterate all repos in tubes-1
for repo_dir in $HOME_DIR; do
    # count total line of codes for php files
    total_lines=$(count_total_lines $repo_dir)

    # run phpcs: count lines containing error for PSR-1
    psr1_count=$(phpcs_lint PSR1 $repo_dir)
    psr1_percentage=$(calculate_percentage $psr1_count $total_lines)

    # run phpcs: count lines c_ontaining error for PSR-2
    psr2_count=$(phpcs_lint PSR2 $repo_dir)
    psr2_percentage=$(calculate_percentage $psr2_count $total_lines)

    echo "$repo_dir,$psr1_percentage,$psr2_percentage"
done
