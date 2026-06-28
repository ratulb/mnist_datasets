---
layout: page
title: MNIST Dataset Loader
---

**A uniform, dependency-light interface to MNIST and Fashion-MNIST.**

Pure Python + NumPy — no PyTorch, no TensorFlow, no framework lock-in. Download, extract, and load both datasets with a single class.

---

## Features

- **Zero framework deps** — just `numpy` and `tqdm`.
- **Automatic download + extraction** — fetches from Azure or AWS S3 on first use.
- **Two datasets** — MNIST handwritten digits and Fashion-MNIST.
- **Multiple formats** — raw binary (IDX) and ARFF.
- **Custom storage** — choose where files live.
- **Static helpers** — `load_images()` / `load_labels()` for low-level access.

---

## Installation

```bash
pip install mnist_datasets
```

Requires Python 3.10 – 3.12.

---

## Quick start

```python
from mnist_datasets import MNISTLoader

loader = MNISTLoader()
images, labels = loader.load()
# images: (60000, 784) uint8, labels: (60000,) uint8

test_images, test_labels = loader.load(train=False)
# test_images: (10000, 784), test_labels: (10000,)
```

---

## API

### MNISTLoader

| Method | Returns | Description |
|--------|---------|-------------|
| `load(train=True)` | `(images, labels)` | Load train (60k) or test (10k) set as NumPy arrays |
| `load_images(path)` | `np.ndarray` | Static — parse raw IDX image file |
| `load_labels(path)` | `np.ndarray` | Static — parse raw IDX label file |
| `from_arff(train=True)` | `(images, labels)` | Static — load from OpenML ARFF format |

### Constructor

```python
MNISTLoader(
    dataset_type="default",    # "default" or "fashion"
    base_url=None,             # override the download URL
    folder=None,               # storage directory (defaults to cwd)
)
```

---

## Examples

### Fashion-MNIST

```python
loader = MNISTLoader('fashion')
images, labels = loader.load()
```

### Custom directory

```python
loader = MNISTLoader(folder='/tmp/mnist_data')
```

### ARFF format (educational)

```python
images, labels = MNISTLoader.from_arff(train=False)
```

### Verify ARFF vs binary consistency

```python
import numpy as np
arff_imgs, arff_lbls = MNISTLoader.from_arff(train=False)
bin_imgs, bin_lbls = MNISTLoader().load(train=False)
np.alltrue(arff_imgs == bin_imgs), np.alltrue(arff_lbls == bin_lbls)
```

### Low-level parsing

```python
images = MNISTLoader.load_images('/tmp/t10k-images-idx3-ubyte')
labels = MNISTLoader.load_labels('/tmp/t10k-labels-idx1-ubyte')
```

---

## Dataset file format

### Image file (`*-images-idx3-ubyte`)

| Offset | Content | Value |
|--------|---------|-------|
| 0–3 | Magic number | 2051 (0x803) |
| 4–7 | Number of images | 60,000 / 10,000 |
| 8–11 | Rows | 28 |
| 12–15 | Columns | 28 |
| 16+ | Pixel data | 0–255 per pixel |

### Label file (`*-labels-idx1-ubyte`)

| Offset | Content | Value |
|--------|---------|-------|
| 0–3 | Magic number | 2049 (0x801) |
| 4–7 | Number of labels | 60,000 / 10,000 |
| 8+ | Label data | 0–9 per byte |

---

## Project structure

| Path | Purpose |
|------|---------|
| `mnist_datasets/loader.py` | `MNISTLoader` class |
| `mnist_datasets/__init__.py` | Public API exports |
| `train.py` | PyTorch training example |
| `mnist.ipynb` | Jupyter notebook demo |
| `setup.py` | PyPI packaging |

---

## License

MIT.
