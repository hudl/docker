FROM hudl/ffmpeg

MAINTAINER Ryan Versaw <ryan.versaw@hudl.com>

RUN apt-get update -y

RUN cd  /

	apt-get install -y cmake
	git clone https://github.com/Itseez/opencv
	git clone https://github.com/Itseez/opencv_contrib
	if [ $? -ne 0 ]; then echo "opencv download failed"; exit 1; fi
	cd opencv
	cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules .
	make && make install
	ldconfig
	cd ..
	rm -rf opencv
	rm -rf opencv_contrib

RUN cd  /

	curl -L http://gnu.mirrorcatalogs.com/gsl/gsl-1.16.tar.gz | tar zxf -
	if [ $? -ne 0 ]; then echo "gsl download failed"; exit 1; fi
	cd gsl-1.16
	./configure
	make && make install
	ldconfig
	cd ..
	rm -rf gsl-1.16