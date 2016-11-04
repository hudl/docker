FROM nvidia/cuda:7.5-cudnn5-devel

MAINTAINER Nathan DeMaria <nathan.demaria@hudl.com>

# Install Torch
RUN apt-get update -y && apt-get install curl sudo libqtcore4 libqtgui4 python-software-properties software-properties-common  -y
RUN curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | sed 's/libqt4-core/libqtcore4/' | sed 's/libqt4-gui/libqtgui4/' | bash
RUN git clone https://github.com/torch/distro.git ~/torch --recursive && cd ~/torch && ./install.sh

# Additional dependencies
RUN ~/torch/install/bin/luarocks install nn && \
	~/torch/install/bin/luarocks install nngraph && \
	~/torch/install/bin/luarocks install luafilesystem && \
	~/torch/install/bin/luarocks install https://raw.github.com/jucor/torch-distributions/master/distributions-0-0.rockspec && \
	~/torch/install/bin/luarocks install cutorch && \
	~/torch/install/bin/luarocks install cunn

