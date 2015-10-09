FROM hudl/opencv

MAINTAINER Ryan Hotovy <ryan.hotovy@hudl.com>

RUN apt-get install -y gdb
RUN apt-get update && apt-get install -y libboost-all-dev --fix-missing

### Docker suggested way of setting up SSH server
### You'll want to add your own key in and later
### disable root login through password

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
