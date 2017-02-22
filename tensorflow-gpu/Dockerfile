FROM nvidia/cuda:8.0-cudnn5-devel
MAINTAINER Nathan DeMaria <nathan.demaria@hudl.com>

# Heavily based on https://github.com/tensorflow/tensorflow/commit/b3edccd6611e4ec365f0f9495a1913c0b4ba6416

ENV CUDA_ROOT /usr/local/cuda/bin
RUN apt-get update -y && apt-get install git wget vim libgtk2.0-0 -y

# Miniconda/basic packages install
RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O install_anaconda.sh && \
    /bin/bash install_anaconda.sh -b -p /opt/conda && \
    /opt/conda/bin/conda update conda && \
    # Set default python to 3.5
    /opt/conda/bin/conda install python=3.5 && \
    rm install_anaconda.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda install -y pip numpy

ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

# Silly workaround 
# RUN curl https://bootstrap.pypa.io/ez_setup.py -o - | python

# TensorFlow Install
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        libcurl3-dev \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        zip \
        zlib1g-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up Bazel.

# We need to add a custom PPA to pick up JDK8, since trusty doesn't
# have an openjdk8 backport.  openjdk-r is maintained by a reliable contributor:
# Matthias Klose (https://launchpad.net/~doko).  It will do until
# we either update the base image beyond 14.04 or openjdk-8 is
# finally backported to trusty; see e.g.
#   https://bugs.launchpad.net/trusty-backports/+bug/1368094
RUN add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends openjdk-8-jdk openjdk-8-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Running bazel inside a `docker build` command causes trouble, cf:
#   https://github.com/bazelbuild/bazel/issues/134
# The easiest solution is to set up a bazelrc file forcing --batch.
RUN echo "startup --batch" >>/root/.bazelrc
# Similarly, we need to workaround sandboxing issues:
#   https://github.com/bazelbuild/bazel/issues/418
RUN echo "build --spawn_strategy=standalone --genrule_strategy=standalone" \
    >>/root/.bazelrc
ENV BAZELRC /root/.bazelrc
# Install the most recent bazel release.
ENV BAZEL_VERSION 0.4.2
WORKDIR /
RUN mkdir /bazel && \
    cd /bazel && \
    curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    curl -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE.txt && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh

# Download and build TensorFlow.

RUN git clone https://github.com/tensorflow/tensorflow.git && \
    cd tensorflow && \
    git checkout r1.0
WORKDIR /tensorflow

# Configure the build for our CUDA configuration.
ENV CI_BUILD_PYTHON python
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
ENV TF_NEED_CUDA 1
ENV TF_CUDA_COMPUTE_CAPABILITIES=3.0,3.5,5.2,6.0,6.1

RUN tensorflow/tools/ci_build/builds/configured GPU && \
	bazel build -c opt --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-mfpmath=both --copt=-msse4.2 --config=cuda tensorflow/tools/pip_package:build_pip_package && \
	bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/pip && \
	# Super-hack to avoid errors uninstalling an old setuptools in the pip install
	rm -r /opt/conda/lib/python3.5/site-packages/setuptools* && \
	pip --no-cache-dir install --upgrade /tmp/pip/tensorflow-*.whl && \
	rm -rf /tmp/pip && rm -rf /root/.cache
# Clean up pip wheel and Bazel cache when done.


