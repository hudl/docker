FROM hudl/ffmpeg

MAINTAINER Ryan Versaw <ryan.versaw@hudl.com>

# Dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    gfortran \
    libatlas-base-dev \
    python \
    python-dev

# pip
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py && rm get-pip.py

# Python stack
COPY ./requirements.txt /root/
RUN pip install -r /root/requirements.txt
RUN rm /root/requirements.txt

# Download OpenCV and extra modules
WORKDIR /
RUN git clone https://github.com/Itseez/opencv.git
WORKDIR /opencv
RUN git checkout tags/3.0.0

WORKDIR /
RUN git clone https://github.com/Itseez/opencv_contrib.git
WORKDIR /opencv_contrib
RUN git checkout tags/3.0.0

# Build OpenCV
WORKDIR /opencv
RUN cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules . && \
    make && make install && \
    ldconfig && \
    cd .. && \
    rm -rf opencv && \
    rm -rf opencv_contrib

RUN cd  / && \
    curl -L http://gnu.mirrorcatalogs.com/gsl/gsl-1.16.tar.gz | tar zxf - && \
    cd gsl-1.16 && \
    ./configure && \
    make && make install && \
    ldconfig && \
    cd .. && \
    rm -rf gsl-1.16

# Install Boost
RUN apt-get update
RUN apt-get install -y libboost-all-dev --fix-missing
RUN echo LC_ALL=C >> /etc/environment

# Install VLFeat
RUN apt-get install -y wget
RUN wget http://www.vlfeat.org/download/vlfeat-0.9.20-bin.tar.gz
RUN tar zxvf vlfeat-0.9.20-bin.tar.gz
Run rm vlfeat-0.9.20-bin.tar.gz
RUN echo VLFEAT_DIR=/vlfeat-0.9.20 >> /etc/environment
