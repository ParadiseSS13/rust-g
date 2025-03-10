#!/bin/bash

PS1="$"
basedir=`pwd`
tg_tag="3.7.0"
clean=$1
echo "Rebuilding patch files from current fork state..."

cleanup_patches() {
    cd "$1"
    for patch in *.patch; do
        gitver=$(tail -n 2 $patch | grep -ve "^$" | tail -n 1)
        diffs=$(git diff --staged $patch | grep -E "^(\+|\-)" | grep -Ev "(From [a-z0-9]{32,}|\-\-\- a|\+\+\+ b|.index)")

        testver=$(echo "$diffs" | tail -n 2 | grep -ve "^$" | tail -n 1 | grep "$gitver")
        if [ "x$testver" != "x" ]; then
            diffs=$(echo "$diffs" | head -n -2)
        fi


        if [ "x$diffs" == "x" ] ; then
            git reset HEAD $patch >/dev/null
            git checkout -- $patch >/dev/null
        fi
    done
}

save_patches() {
    what=$1
    target=$2
    branch=$3
    cd "$basedir/$target"
    git format-patch --no-stat -N -o "../${target}-patches/" $branch
    cd "$basedir"
    git add -A "${target}-patches"
    if [ "$clean" != "clean" ]; then
        cleanup_patches "${target}-patches"
    fi
    echo "  Patches saved for $what to $target-patches/"
}
if [ "$clean" == "clean" ]; then
    rm -rf *-patches
fi
save_patches tg-rust-g paradise-rust-g $tg_tag