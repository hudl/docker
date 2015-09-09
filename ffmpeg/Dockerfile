FROM ubuntu:14.04

MAINTAINER Ryan Versaw <ryan.versaw@hudl.com>

RUN apt-get update -y
RUN apt-get -y install git subversion yasm unzip mediainfo ntp ruby autoconf automake build-essential curl pkg-config texi2html zlib1g-dev

ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

# FFMPEG package deps
RUN apt-get -y install libmp3lame-dev libxvidcore-dev libxml2-utils libass-dev libgpac-dev libtheora-dev libtool libvorbis-dev 

RUN apt-get install -y bzip2 make gcc automake autoconf libtool yasm nasm git

RUN	export LD_LIBRARY_PATH=/usr/local/lib/ && \
	echo /usr/local/lib > /etc/ld.so.conf.d/custom-libs.conf && \
	ldconfig 
	
RUN curl -L http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.3.tar.gz | tar zxf - && \
	cd opencore-amr-0.1.3 && \
	./configure && \
	make && make install && \
	ldconfig && \
	cd .. && \
	rm -rf opencore-amr-0.1.3
	
RUN	curl -L http://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-0.1.3.tar.gz | tar zxf - && \
	cd fdk-aac-0.1.3 && \
	./configure && \
	make && make install && \
	ldconfig && \
	cd .. && \
	rm -rf fdk-aac-0.1.3 
	
RUN	curl -L http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz | tar zxf - && \
	cd libogg-1.3.2 && \
	./configure && \
	make && make install && \
	ldconfig && \
	cd .. && \
	rm -rf libogg-1.3.2 

RUN git clone git://git.videolan.org/x264.git && \
	cd x264 && \
	./configure --enable-shared && \
	make && make install && \
	ldconfig && \
	cd .. && \
	rm -rf x264 
	
RUN curl -L https://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2 | tar xjf - && \
	cd libvpx-v1.3.0 && \
	./configure --enable-shared && \
	make && make install && \
	ldconfig && \
	cd .. && \
	rm -rf libvpx-v1.3.0
	
RUN	curl -L http://ffmpeg.org/releases/ffmpeg-2.7.2.tar.bz2 | tar xjf - && \
	cd ffmpeg && \
	./configure --enable-avfilter --enable-version3 --enable-libopencore-amrnb --enable-libopencore-amrwb \
		--enable-libvpx --enable-libfdk_aac --enable-libmp3lame --enable-libtheora --enable-libvorbis \
		--enable-libx264 --enable-libxvid --enable-gpl --enable-postproc --enable-nonfree --enable-shared && \
	make && make install && \
	ldconfig && \
	cd tools && \
	make qt-faststart && \
	cp qt-faststart /usr/local/bin && \
	ldconfig && \
	cd ../.. && \
	rm -rf ffmpeg 

RUN apt-get install -y perl-ExtUtils-MakeMaker 

RUN	curl -L http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-9.84.tar.gz | tar zxf - && \
	cd Image-ExifTool-9.84 && \
	perl Makefile.PL && \
	make && make install && \
	cd .. && \
	rm -rf Image-ExifTool-9.84