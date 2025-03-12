#### Load the MNIST (handwritten) dataset from raw source files with a complete from-scratch implementation that is independent of any framework or libraries.

#### MNIST dataset for hande-written digits come in four files, namely:
* [train-images-idx3-ubyte.gz](https://storage.googleapis.com/cvdf-datasets/mnist/train-images-idx3-ubyte.gz) (60000 train images)
* [train-labels-idx1-ubyte.gz](https://storage.googleapis.com/cvdf-datasets/mnist/train-labels-idx1-ubyte.gz) (60000 train labels)
* [t10k-images-idx3-ubyte.gz](https://storage.googleapis.com/cvdf-datasets/mnist/t10k-images-idx3-ubyte.gz)  (10000 test images)
* [t10k-labels-idx1-ubyte.gz](https://storage.googleapis.com/cvdf-datasets/mnist/t10k-labels-idx1-ubyte.gz)  (10000 test labels)

#### Note: The [original site](http://yann.lecun.com/exdb/mnist/) for the dataset currently does not contain much information.

#### Each of these compressed files, when uncompressed(using gunzip etc), results in one single output file.

#### The content storage structure for image and label files are different. Shown below are the structures for image and label files.
#### Big-endian binary format image files: (*-images-idx3-ubyte)
| Offset(Bytes)  | Content  | Description  |
|-----------|-----------|-----------|
| 0 - 3     | Magic number        | 2051(0x803 in hex)    |
| 4 - 7     | Number of images    | Total number of images in the dataset    |
| 8 - 11    | Rows(height)        | Should be 28    |
| 12 - 15   | Columns(width)      | Should be 28    |
| 16 - ***  | Pixel data          | Each pixel unsigned value in the range (0, 255)    |

> **Note:** Each image is stored as 28 by 28 = 784-Byte sequence.
#### Big-endian binary format label files:(*-labels-idx1-ubyte)
| Offset(Bytes)  | Content  | Description  |
|-----------|-----------|-----------|
| 0 - 3     | Magic number        | 2049(0x801 in hex)    |
| 4 - 7     | Number of labels    | Total number of labels in the dataset    |
| 8 - ***    | Label Data        | Each label(0 - 9) single byte    |
> **Note:** Each label is single byte (0 to 9)

### Installtion
* `pip install mnist_datasets`

### Using
  ```python
from mnist_datasets import MNISTLoader
loader = MNISTLoader()
images, labels = loader.load()
assert len(images) == 60000 and len(labels) == 60000
test_images, test_labels = loader.load(train=False)
assert len(test_images) == 10000 and len(test_labels) == 10000
```
### To load data to a specific folder
  ```python
loader = MNISTLoader(folder='/tmp')
```

### To load data from arff file
  ```python
images_from_arff, labels_from_arff = MNISTLoader.from_arff()
```
> **Note:** Default arff file is `https://www.openml.org/data/download/52667/mnist_784.arff`.
> MNISTLoader.from_arff() is inherently slow and the implementation is only for educational purpose.

### Load `arff` **test images**/labels and corresponding images/labels via `MNISTLoader(train=False).load()` and verify that they are, in deed, same.
  ```python
import numpy as np
images_from_arff, labels_from_arff = MNISTLoader.from_arff(train=False)
images, labels = MNISTLoader().load(train=False)
np.alltrue(images_from_arff == images), np.alltrue(labels_from_arff == labels)
```
### Load images and labels from local storage
  ```python
images = MNISTLoader.load_images('/tmp/t10k-images-idx3-ubyte')
labels = MNISTLoader.load_labels('/tmp/t10k-labels-idx1-ubyte')
assert len(images == 10000) and len(labels == 10000)
```
