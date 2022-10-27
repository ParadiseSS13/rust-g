#!/bin/sh

basedir=`pwd`
tg_tag="1.1.0"

echo "Checking for TG rust-g repo.."
if [ ! -d "./tg-rust-g" ] 
then
    echo "TG rust-g does not exist locally. Cloning..."
    git clone https://github.com/tgstation/rust-g.git tg-rust-g
fi

echo "Setting up project... "

cd "$basedir/tg-rust-g"
git reset --hard $tg_tag

apply_patch() {
    what=$1
    target=$2
    branch=$3

    cd "$basedir"
    if [ ! -d  "$target" ]; then
        git clone $what $target
    fi
    cd "$basedir/$target"
    echo "Resetting $target to $what..."
    git config commit.gpgSign false
    git remote rm origin >/dev/null 2>&1
    git remote add origin ../$what >/dev/null 2>&1
    git checkout master >/dev/null 2>&1
    git fetch origin >/dev/null 2>&1
    git reset --hard $branch

    echo "  Applying patches to $target..."
    git am --abort >/dev/null 2>&1
    git am --3way --ignore-space-change --ignore-whitespace "../${target}-patches/"*.patch
    if [ "$?" != "0" ]; then
        echo "  Something did not apply cleanly to $target."
        echo "  Please review above details and finish the apply then"
        echo "  save the changes with rebuild_patches.sh"
        exit 1
    else
        echo "  Patches applied cleanly to $target"
    fi
}

apply_patch tg-rust-g paradise-rust-g origin/master
