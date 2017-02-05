#!/bin/bash

# get the arguments
arg_app=$1            # the application e.g. "SABnzbd"
arg_branch=$2         # the git branch e.g. "master"
arg_repo=$3           # the git repository e.g. "https://github.com/Technosoft2000/docker-sabnzbd.git"
arg_directory=$4      # the application directory e.g. "/sabnzbd/app"

# download the latest version of the specified application
echo "[INFO] Current git version is:" && git version
echo "[INFO] Checkout the latest $arg_app version ..."
if [ ! -d $arg_directory/.git ]; then
    # clone the repository
    echo "[INFO] ... git clone -b $arg_branch --single-branch $arg_repo $arg_directory -v"
    gosu $PUSER:$PGROUP bash -c "git clone -b $arg_branch --single-branch $arg_repo $arg_directory -v"
fi

# opt out for autoupdates using env variable
if [ -z "$ADVANCED_DISABLEUPDATES" ]; then
    echo "[INFO] Autoupdate is active, try to pull the latest sources for $arg_app ..."
    cd $arg_directory
    echo "[INFO] ... current git status is"
    gosu $PUSER:$PGROUP bash -c "git status && git rev-parse $arg_branch"
    echo "[INFO] ... pulling sources"
    gosu $PUSER:$PGROUP bash -c "git pull"
    echo "[INFO] ... git status after update is"
    gosu $PUSER:$PGROUP bash -c "git status && git rev-parse $arg_branch"
fi