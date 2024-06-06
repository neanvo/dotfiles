#!/bin/bash

function display_error_and_exit {
  echo "⚠️ Error: $1"
  exit 1
}

# Check if the script is being run by the root user
if [ "$(id -u)" -eq 0 ]; then
  display_error_and_exit "This script should not be run as root."
fi

