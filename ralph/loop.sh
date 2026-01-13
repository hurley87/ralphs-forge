#!/bin/bash

PROMPT_FILE="ralph/PROMPT.md"
MAX_ITERATIONS=${1:-10}

echo "🍩 Starting Ralph... (Max loops: $MAX_ITERATIONS)"

counter=0
while [ $counter -lt $MAX_ITERATIONS ]; do
    echo "--- Loop #$((counter+1)) ---"
    cat "$PROMPT_FILE" | claude --dangerously-skip-permissions
    counter=$((counter+1))
    sleep 1
done

echo "🍩 Ralph finished."