
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
RUN (echo "toolkit_path;set_global_variable('native_download',false);workspace_create"; echo 2; echo Algorithm) | octave
WORKDIR /vot-2013-workspace/sequences
RUN wget http://box.vicos.si/vot/vot2013.zip && \
    unzip vot2013 && \
    rm vot2013.zip
WORKDIR /vot-2013-workspace/results
RUN wget http://box.vicos.si/vot/vot2013_results.zip && \
    unzip vot2013_results && \
    rm vot2013_results.zip  
WORKDIR /vot-2013-workspace
RUN touch vot2013.txt && \
    (echo "PLT";  echo "FoT"; echo "EDFT"; echo "LGTpp"; echo "LT-FLO") >>  vot2013.txt

WORKDIR /vot-2014-workspace
RUN (echo "toolkit_path;set_global_variable('native_download',false);workspace_create"; echo 4; echo Algorithm) | octave
WORKDIR /vot-2014-workspace/sequences
RUN wget http://box.vicos.si/vot/vot2014.zip && \
    unzip vot2014 && \
    rm vot2014.zip
WORKDIR /vot-2014-workspace/results
RUN wget http://box.vicos.si/vot/vot2014_results.zip && \
    unzip vot2014_results && \
    rm vot2014_results.zip
WORKDIR /vot-2014-workspace
RUN touch vot2014.txt && \
    (echo "DSST";  echo "SAMF"; echo "KCF"; echo "DGT"; echo "PLT_14"; echo "PLT_13") >>  vot2014.txt

WORKDIR /vot-2015-workspace
RUN (echo "toolkit_path;set_global_variable('native_download',false);workspace_create"; echo 5; echo Algorithm) | octave
WORKDIR /vot-2015-workspace/sequences
RUN wget http://box.vicos.si/vot/vot2015.zip && \
    unzip vot2015 && \
    rm vot2015.zip
WORKDIR /vot-2015-workspace/results
RUN wget http://box.vicos.si/vot/vot2015_results.zip && \
    unzip vot2015_results && \
    rm vot2015_results.zip
WORKDIR /vot-2015-workspace
RUN touch vot2015.txt && \
    (echo "MDnet";  echo "DeepSRDCF"; echo "EBT"; echo "srdcf"; echo "LDP"; echo "sPST") >>  vot2015.txt

# Compile Trax
RUN cd /vot-toolkit/native/trax && mkdir build && cd build \
     && cmake .. && make  && make install

# Define default command.
WORKDIR /
CMD ["/bin/bash"]
