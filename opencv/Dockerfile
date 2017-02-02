FROM hudl/ffmpeg:latest
MAINTAINER Ryan Versaw <ryan.versaw@hudl.com>

RUN apt-get update && apt-get install -y \
    cmake \
    gfortran \
    libatlas-base-dev \
    wget

RUN apt-get install software-properties-common -y && \
    add-apt-repository ppa:george-edison55/cmake-3.x && \
    apt-get update && \
    apt-get upgrade cmake -y

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O install_miniconda.sh && \
    /bin/bash install_miniconda.sh -b -p /opt/conda && \
    rm install_miniconda.sh
ENV PATH /opt/conda/bin:$PATH

RUN pip install --upgrade pip
RUN pip install Cython==0.24
RUN pip install --upgrade --ignore-installed https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0-cp35-cp35m-linux_x86_64.whl

RUN conda install numpy -y

WORKDIR /
RUN git clone https://github.com/Itseez/opencv.git
WORKDIR /opencv
RUN git checkout tags/3.2.0

WORKDIR /
RUN git clone https://github.com/Itseez/opencv_contrib.git
WORKDIR /opencv_contrib
RUN git checkout tags/3.2.0

WORKDIR /opencv
RUN cmake -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=/opt/opencv \
    -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
    -D BUILD_opencv_python3=True \
    -D OPENCV_FORCE_PYTHON_LIBS=True \
    -D PYTHON3_INCLUDE_DIR=/opt/conda/include/python3.5m \
    -D PYTHON3_LIBRARY=/opt/conda/lib/libpython3.5m.so \
    -D PYTHON3_EXECUTABLE=/opt/conda/bin/python3.5 \
    -D PYTHON3_NUMPY_INCLUDE_DIRS=/opt/conda/pkgs/numpy-1.11.3-py35_0/lib/python3.5/site-packages/numpy/core/include \
    -D PYTHON3_PACKAGES_PATH=/opt/conda/lib/python3.5/site-packages \
    -D BUILD_EXAMPLES=False \
    -D INSTALL_PYTHON_EXAMPLES=False \
    -D INSTALL_C_EXAMPLES=False \
    -D BUILD_DOCS=False \
    -D BUILD_TESTS=False \
    -D BUILD_PERF_TESTS=False \
    .

RUN make -j8 && make install && \
    ldconfig && \
    cd .. && \
    rm -rf opencv && \
    rm -rf opencv_contrib
