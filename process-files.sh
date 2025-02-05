#!/bin/bash

# Set API endpoints
JS_API_URL="http://localhost:3000/process-js"
CSS_API_URL="http://localhost:3000/process-css"

# File containing the list of JS and CSS files
FILE_LIST="file-paths.txt"

# Check if the file list exists
if [ ! -f "$FILE_LIST" ]; then
    echo "❌ Error: File list '$FILE_LIST' not found!"
    exit 1
fi

# Read each line from the file list
while IFS= read -r file_path || [[ -n "$file_path" ]]; do
    # Trim spaces and remove quotes
    file_path=$(echo "$file_path" | tr -d '\r' | tr -d '"')

    # Skip empty lines
    if [[ -z "$file_path" ]]; then
        continue
    fi

    echo "📂 Processing file: $file_path"

    # Check if file exists
    if [ ! -f "$file_path" ]; then
        echo "⚠️ Warning: File '$file_path' not found! Skipping..."
        continue
    fi

    # Determine file extension
    extension="${file_path##*.}"

    # Send request based on file type
    if [[ "$extension" == "js" ]]; then
        API_URL="$JS_API_URL"
        OUTPUT_FILE="${file_path%.js}.min.js"
    elif [[ "$extension" == "css" ]]; then
        API_URL="$CSS_API_URL"
        OUTPUT_FILE="${file_path%.css}.min.css"
    else
        echo "⚠️ Warning: Unsupported file type '$extension' for file '$file_path'. Skipping..."
        continue
    fi

    # Encode file content properly using jq
    file_content=$(jq -Rs . < "$file_path")

    # Send request using curl
    response=$(curl -s -X POST "$API_URL" \
        -H "Content-Type: application/json" \
        -d "{\"code\": $file_content}")

    # Extract minified content
    minified_code=$(echo "$response" | jq -r '.minified')

    # Check if the response contains valid minified data
    if [[ "$minified_code" == "null" ]]; then
        echo "❌ Error processing '$file_path'. API response: $response"
        continue
    fi

    # Save minified/obfuscated file
    echo "$minified_code" > "$OUTPUT_FILE"
    echo "✅ Processed: '$file_path' → '$OUTPUT_FILE'"

done < "$FILE_LIST"

echo "🎉 All files processed successfully!"
