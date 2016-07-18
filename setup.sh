#!/usr/bin/env bash

echo -e "Hey, let's set up your workstation\n"
echo -e "All workstations follow the same naming convention: your_name.workstation.dev\n"
echo -n "So, what's your name? [ENTER]: "
read NAME
CLEANNAME=${NAME//[^a-zA-Z0-9_]/};
CLEANNAME=`echo -n $CLEANNAME | tr A-Z a-z`
CUSTOM_HOST="${CLEANNAME}.workstation.dev"

read -p "Aha! your workstation name will be called ${CUSTOM_HOST}. Continue?" CHOICE

case "$CHOICE" in
  y|Y ) echo -e "It's time to vagrant up!"; CUSTOM_HOST=$CUSTOM_HOST vagrant up;;
  n|N ) echo "Ok, bye...";;
  * ) echo "invalid";;
esac
