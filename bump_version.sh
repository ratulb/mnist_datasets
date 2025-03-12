#!/usr/bin/env bash

# Extract the current version from setup.py
CURRENT_VERSION=$(grep -oP 'version="\K[0-9]+\.[0-9]+(\.[0-9]+)?' setup.py)

if [[ -z "$CURRENT_VERSION" ]]; then
  echo "Error: Could not find version in setup.py"
  exit 1
fi

# Split version into parts
IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"

# Logic to increment version
if [[ ${#VERSION_PARTS[@]} -eq 2 ]]; then
  # If version is in format X.Y (e.g., 1.8), increment minor version
  NEW_VERSION="${VERSION_PARTS[0]}.$((${VERSION_PARTS[1]} + 1))"
elif [[ ${#VERSION_PARTS[@]} -eq 3 ]]; then
  # If version is in format X.Y.Z (e.g., 1.8.2), increment patch version
  NEW_VERSION="${VERSION_PARTS[0]}.${VERSION_PARTS[1]}.$((${VERSION_PARTS[2]} + 1))"
else
  echo "Error: Unsupported version format."
  exit 1
fi

# Update version in setup.py
sed -i "s/version=\"$CURRENT_VERSION\"/version=\"$NEW_VERSION\"/" setup.py

echo "Version updated: $CURRENT_VERSION → $NEW_VERSION"

