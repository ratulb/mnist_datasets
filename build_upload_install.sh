#!/usr/bin/env bash

pip uninstall mnist_datasets -y
rm -rf dist/ *.egg-info/
#pip install build
python3 -m build
#pip install twine

twine upload dist/*

pip cache purge
sleep 1
pip install --no-cache-dir mnist_datasets
