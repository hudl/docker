FROM hudl/ffmpeg

MAINTAINER Ryan Versaw <ryan.versaw@hudl.com>

RUN apt-get update -y

ADD install_opencv.sh /install_opencv.sh
RUN /install_opencv.sh

ADD install_gsl.sh /install_gsl.sh
RUN /install_gsl.sh