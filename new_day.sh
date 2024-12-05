#!/bin/bash

# Get the current day and year
CURRENT_DAY=$(date +%d)   # Current day in two digits
CURRENT_YEAR=$(date +%Y)  # Current year

# Use provided day or default to current day
DAY=$(printf "%02d" "${1:-$CURRENT_DAY}") # Use argument or current day if none provided

BASE_DIR="$CURRENT_YEAR"  # Base directory for the year
TEMPLATE_DIR="template"   # Name of your template folder
NEW_DIR="$BASE_DIR/$DAY" # New folder structure

# Ensure the template folder exists
if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "Error: Template folder '$TEMPLATE_DIR' not found."
  exit 1
fi

# Create the base directory for the current year if it doesn't exist
mkdir -p "$BASE_DIR"

# Copy the template folder
cp -r "$TEMPLATE_DIR" "$NEW_DIR"

# Replace "XX" with the day number in file contents
find "$NEW_DIR" -type f | while read -r FILE; do
  sed -i '' "s/XX/$DAY/g" "$FILE"
done

echo "New folder created: $NEW_DIR"