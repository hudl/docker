FROM ubuntu:14.04

MAINTAINER Ben Cook <ben.cook@hudl.com>

# OpenCV requirements
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gfortran \
    git \
    libatlas-base-dev \
    libavcodec-dev \
    libavformat-dev \
    libgtk2.0-dev \
    libjasper-dev \
    libjpeg8-dev \
    libpng12-dev \
    libswscale-dev \
    libtiff4-dev \
    libv4l-dev \
    pkg-config \
    python \
    python-dev \
    python-pip \
    wget

# Python stack
COPY ./requirements.txt /root/
RUN pip install -r /root/requirements.txt
RUN rm /root/requirements.txt

# Download OpenCV and extra modules
WORKDIR /opt
RUN git clone https://github.com/Itseez/opencv.git
WORKDIR /opt/opencv
RUN git checkout 3.0.0

WORKDIR /opt
RUN git clone https://github.com/Itseez/opencv_contrib.git
WORKDIR /opt/opencv_contrib
RUN git checkout 3.0.0

# Build OpenCV
RUN mkdir /opt/opencv/build
WORKDIR /opt/opencv/build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..
RUN make -j8 && make install && ldconfig

# Clean up
WORKDIR /opt
RUN rm -rf opencv opencv_contrib

# Configure jupyter
WORKDIR /root
RUN mkdir .jupyter
COPY ./jupyter_notebook_config.py /root/.jupyter/
EXPOSE 8888
CMD ipython notebook