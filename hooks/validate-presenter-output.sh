#!/bin/bash
# Hook: aws-docs-presenter output validation

response=$(cat)

if ! echo "$response" | grep -q "\[AWS-DOC\]"; then
    echo "ERROR: Missing [AWS-DOC] tags" >&2
    exit 1
fi

if ! echo "$response" | grep -q "https://"; then
    echo "ERROR: Missing URLs" >&2
    exit 1
fi

if ! echo "$response" | grep -q "Important Limitations"; then
    echo "ERROR: Missing Important Limitations section" >&2
    exit 1
fi

echo "$response"
