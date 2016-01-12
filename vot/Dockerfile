
FROM hudl/cvdev

MAINTAINER Joan Alabort <joan.alabort@hudl.com>

# Install build & basic dependencies
RUN apt-get -y update
RUN apt-get install -y build-essential cmake vim wget git

# Install Octave 4.0 & packages
RUN sudo apt-get update
RUN apt-get install -y software-properties-common
RUN sudo apt-add-repository ppa:octave/stable
RUN sudo apt-get update
RUN sudo apt-get install -y octave liboctave-dev zip
RUN echo "pkg install -forge -auto image" | octave
RUN echo "pkg install -forge -auto io" | octave
RUN echo "pkg install -forge -auto statistics" | octave

# Add VOT-toolkit
WORKDIR /
RUN git clone https://github.com/votchallenge/vot-toolkit

WORKDIR /vot-toolkit
RUN echo "addpath ('/vot-toolkit');" >> ~/.octaverc

# Setup test workspaces & downloads TraX precompiled files
WORKDIR /vot-2013-workspace
RUN (echo "toolkit_path;set_global_variable('native_download',false);workspace_create"; echo 2; echo MSS_Tracker) | octave

WORKDIR /vot-2014-workspace
RUN (echo "toolkit_path;set_global_variable('native_download',false);workspace_create"; echo 4; echo MSS_Tracker) | octave

WORKDIR /vot-2015-workspace
RUN (echo "toolkit_path;set_global_variable('native_download',false);workspace_create"; echo 5; echo MSS_Tracker) | octave

# Compile Trax
RUN cd /vot-toolkit/native/trax && mkdir build && cd build \
     && cmake .. && make  && make install

WORKDIR /
# Define default command.
CMD ["/bin/bash"]
