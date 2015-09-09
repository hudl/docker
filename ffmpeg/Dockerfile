FROM ubuntu:14.04

MAINTAINER Ryan Versaw <ryan.versaw@hudl.com>

RUN apt-get update -y
RUN apt-get -y install git subversion yasm unzip mediainfo ntp ruby autoconf automake build-essential curl pkg-config texi2html zlib1g-dev

ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

# FFMPEG package deps
RUN apt-get -y install libmp3lame-dev libxvidcore-dev libxml2-utils libass-dev libgpac-dev libtheora-dev libtool libvorbis-dev 

ADD install_ffmpeg.sh /install_ffmpeg.sh
RUN /install_ffmpeg.sh

ADD install_exiftool.sh /install_exiftool.sh
RUN /install_exiftool.sh