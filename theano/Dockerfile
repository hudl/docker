FROM kaixhin/cudnn:latest
MAINTAINER Nathan DeMaria <nathan.demaria@hudl.com>

ENV CUDA_ROOT /usr/local/cuda/bin

RUN wget --quiet https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda2-2.5.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda2-2.5.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda2-2.5.0-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH

RUN apt-get install git python-pip python-qt4 vim -y

RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git

# .theanorc
RUN echo "[global]\ndevice=gpu\nfloatX=float32\n[nvcc]\nfastmath=True" > /root/.theanorc

# jupyter notebook
RUN mkdir /root/.jupyter
COPY ./jupyter_notebook_config.py /root/.jupyter

# Docker's SSH server setup
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:<REPLACE THIS WITH DEFAULT ROOT PASSWORD>' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


EXPOSE 22 8888
WORKDIR /root/notebooks/
CMD /usr/sbin/sshd -D & ipython notebook

