#!/usr/bin/env bash

# Uninstall old package
pip uninstall mnist_datasets -y

# Clean old builds
rm -rf dist/ *.egg-info/

# Build package
pip install --upgrade build
python3 -m build

# Install twine if not present
pip install --upgrade --user twine

# Upload using Python to avoid PATH issues
python3 -m twine upload dist/*

# Clear cache and reinstall
pip cache purge
sleep 2
pip install --no-cache-dir mnist_datasets

