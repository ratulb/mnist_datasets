# MNIST Dataset Loader

An **uniform** interface to the MNIST handwritten digits(default) and MNIST fashion datasets, independent of any machine learning framework or external libraries except `numpy`. This implementation enables downloading, extracting, and loading the dataset effortlessly.

## Features
- **Pure Python + NumPy**: No dependencies on deep learning frameworks.
- **Automatic Download & Extraction**: Fetches and prepares the dataset automatically.
- **Supports Raw MNIST Format**: Loads images and labels directly from binary files.
- **ARFF Format Support**: Provides an option to load data from an ARFF file.
- **Custom Storage Location**: Allows specifying a custom directory for storing dataset files.

## MNIST Dataset Structure
The MNIST dataset consists of four binary files:

| File | Description | Count |
|------|------------|-------|
| [train-images-idx3-ubyte.gz](https://storage.googleapis.com/cvdf-datasets/mnist/train-images-idx3-ubyte.gz) | Training images | 60,000 |
| [train-labels-idx1-ubyte.gz](https://storage.googleapis.com/cvdf-datasets/mnist/train-labels-idx1-ubyte.gz) | Training labels | 60,000 |
| [t10k-images-idx3-ubyte.gz](https://storage.googleapis.com/cvdf-datasets/mnist/t10k-images-idx3-ubyte.gz) | Test images | 10,000 |
| [t10k-labels-idx1-ubyte.gz](https://storage.googleapis.com/cvdf-datasets/mnist/t10k-labels-idx1-ubyte.gz) | Test labels | 10,000 |

> **Note:** The [original MNIST site](http://yann.lecun.com/exdb/mnist/) does not provide detailed information about the dataset files.

## File Format Breakdown
### Image File Format (`*-images-idx3-ubyte`)
| Offset (Bytes) | Content | Description |
|---------------|---------|-------------|
| 0 - 3 | Magic number | 2051 (0x803 in hex) |
| 4 - 7 | Number of images | Total images in the dataset |
| 8 - 11 | Rows | Should be 28 |
| 12 - 15 | Columns | Should be 28 |
| 16 - *** | Pixel data | Each pixel is an unsigned value (0-255) |

### Label File Format (`*-labels-idx1-ubyte`)
| Offset (Bytes) | Content | Description |
|---------------|---------|-------------|
| 0 - 3 | Magic number | 2049 (0x801 in hex) |
| 4 - 7 | Number of labels | Total labels in the dataset |
| 8 - *** | Label Data | Each label is a single byte (0-9) |

## Installation
Install the package via pip:
```bash
pip install mnist_datasets
```

## Usage
### Load MNIST Dataset
```python
from mnist_datasets import MNISTLoader
loader = MNISTLoader()
images, labels = loader.load()
assert len(images) == 60000 and len(labels) == 60000

# Load test dataset
test_images, test_labels = loader.load(train=False)
assert len(test_images) == 10000 and len(test_labels) == 10000
```

### Specify a Custom Folder
```python
loader = MNISTLoader(folder='/tmp')
```

### Load Data from an ARFF File
```python
images_from_arff, labels_from_arff = MNISTLoader.from_arff()
```
> **Note:** Default ARFF file source (for handwritten digits) is `https://www.openml.org/data/download/52667/mnist_784.arff`.
> This method is provided for educational purposes and extremley slow.

### Verify Consistency Between ARFF and MNIST Binary Format
```python
import numpy as np
images_from_arff, labels_from_arff = MNISTLoader.from_arff(train=False)
images, labels = MNISTLoader().load(train=False)
np.alltrue(images_from_arff == images), np.alltrue(labels_from_arff == labels)
```

### Load Images and Labels from Local Storage
```python
images = MNISTLoader.load_images('/tmp/t10k-images-idx3-ubyte')
labels = MNISTLoader.load_labels('/tmp/t10k-labels-idx1-ubyte')
assert len(images) == 10000 and len(labels) == 10000
```
> **Note:** All of the above examples would work for [fashion MNIST](https://github.com/zalandoresearch/fashion-mnist) with just following tweak:
```python
loader = MNISTLoader('fashion')
```
 
---
### Why use this? 

This project is designed for those who want an intuitive and dependency-free way to load the MNIST dataset while understanding its raw format in depth.

### Contributions & Issues: 

Found a bug? Want to contribute? Feel free to open an issue or submit a PR!

