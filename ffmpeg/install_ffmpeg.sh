apt-get install -y bzip2 make gcc gcc-c++ automake autoconf libtool yasm nasm git

export LD_LIBRARY_PATH=/usr/local/lib/
echo /usr/local/lib > /etc/ld.so.conf.d/custom-libs.conf
ldconfig

curl -L http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.3.tar.gz | tar zxf -
if [ $? -ne 0 ]; then echo "opencore-amr download failed"; exit 1; fi
cd opencore-amr-0.1.3
./configure
make && make install
ldconfig
cd ..
rm -rf opencore-amr-0.1.3

curl -L http://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-0.1.3.tar.gz | tar zxf -
if [ $? -ne 0 ]; then echo "fdk-aac download failed"; exit 1; fi
cd fdk-aac-0.1.3
./configure
make && make install
ldconfig
cd ..
rm -rf fdk-aac-0.1.3

curl -L http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz | tar zxf -
if [ $? -ne 0 ]; then echo "ogg download failed"; exit 1; fi
cd libogg-1.3.2
./configure
make && make install
ldconfig
cd ..
rm -rf libogg-1.3.2

git clone git://git.videolan.org/x264.git
if [ $? -ne 0 ]; then echo "x264 download failed"; exit 1; fi
cd x264
./configure --enable-shared
make && make install
ldconfig
cd ..
rm -rf x264

curl -L https://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2 | tar xjf -
if [ $? -ne 0 ]; then echo "vpx download failed"; exit 1; fi
cd libvpx-v1.3.0
./configure --enable-shared
make && make install
ldconfig
cd ..
rm -rf libvpx-v1.3.0

curl -L http://ffmpeg.org/releases/ffmpeg-2.7.2.tar.bz2 | tar xjf -
if [ $? -ne 0 ]; then echo "ffmpeg download failed"; exit 1; fi
cd ffmpeg
./configure --enable-avfilter --enable-version3 --enable-libopencore-amrnb --enable-libopencore-amrwb \
	--enable-libvpx --enable-libfdk_aac --enable-libmp3lame --enable-libtheora --enable-libvorbis \
	--enable-libx264 --enable-libxvid --enable-gpl --enable-postproc --enable-nonfree --enable-shared
make && make install
ldconfig
cd tools
make qt-faststart
cp qt-faststart /usr/local/bin
ldconfig
cd ../..
rm -rf ffmpeg