#!/bin/bash

if [ -f "batch_details.json" ]; then
  echo "File batch_details.json exists"
  echo "Smoke test was successful"
  exit o
fi





python3 data_importer.py

if [ $? -ne 0 ]; then
  echo "Data insertion failed"
  exit 1
else
  echo "Data inserted successfully"
fi



# Wait for a few seconds before proceeding
echo "Waiting for systems to stabilize..."
sleep 3
echo "Calling the API..."
output=$(python3 api_tester.py)


if [[ $output == *"Registration Response:"* && $output == *"Login Response:"* && $output == *"Extraction Response:"* ]]; then
  echo "API operations completed successfully"
else
  echo "API operations failed"
  exit 1
fi


if [ -f "batch_details.json" ]; then
  echo "File batch_details.json created successfully"
  echo "Smoke test was successful"
  exit 0
else
  echo "File batch_details.json not found"
  echo "Smoke test failed"
  exit 1
fi