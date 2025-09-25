from setuptools import setup

setup(
    name="mnist_datasets", 
    version="0.13",
    packages=["mnist_datasets"],  
    install_requires=['numpy', 'tqdm'],  
    author="Ratul Buragohain",
    author_email="ratul75@hotmail.com",
    description="A Python module to load mnist_datasets from scratch",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    url="https://github.com/ratulb/mnist_datasets",
    classifiers=[
        "Programming Language :: Python :: 3.10",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.10",
)

