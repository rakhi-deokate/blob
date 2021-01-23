#!/bin/bash
# File: ~/launch.sh

# Original Code Reference: http://dan.doezema.com/2013/04/programmatically-create-title-tabs-within-the-mac-os-x-terminal-app/
# New-BSD License by Original Author Daniel Doezema http://dan.doezema.com/licenses/new-bsd/

# Modified by Luke Schoen in 2017 to include loading new tabs for Rails Server and automatically open webpage in browser.

# References: https://developer.apple.com/library/content/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html

# Instructions:
#
# - Go to root directory of a Ruby on Rails project
# - Enter the following in Bash Terminal `bash launch_dev.sh`, which creates a new
#   Terminal tab that executes the Rails server, and after 10 seconds it opens a
#   second new Terminal tab that runs the `open http://localhost:3000` command to
#   open the website of the Rails server in your web browser (after waiting 10 seconds
#   to ensure the Rails Server has fully loaded)

# About:
# 
# Shell function to setup Developer Environment with command
# `bash launch_dev.sh` using osascript command to execute custom
# AppleScript code that instructs the Terminal app to
# open multiple new Terminal.app tabs automatically, naming the tabs,
# and attaching them to Terminal Multiplexer (tmux) Sessions,
# by simulating the keypress of CMD+T
# and running a script with chained commands that set the
# new Terminal tab's title. The $COMMAND variable is also
# evaluated and executed in both new tabs. Output from original
# call to osascript is redirected to /dev/null

function new_tab() {
  TAB_NAME=$1
  DELAY=$2
  COMMAND=$3
  osascript \
    -e "tell application \"Terminal\"" \
    -e "tell application \"System Events\" to keystroke \"t\" using {command down}" \
    -e "do script \"$DELAY; printf '\\\e]1;$TAB_NAME\\\a'; $COMMAND\" in front window" \
    -e "end tell" > /dev/null
}

# Create new tabs to load the Rails Server and show logs.
new_tab "Server Run Tab" \
			  "echo 'Loading Rails Server...'" \
			  "cd ~/code/apps/rails_csv_app; rails s;"

# Create another new tab to wait 10 seconds to Rails Server to load, 
# then automatically open web server in browser from command line.
new_tab "Server Browser Tab" \
			  "echo 'Waiting for Rails Server...'; sleep 10" \
	 		  "cd ~/code/apps/rails_csv_app; open http://localhost:3000;"
