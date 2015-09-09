cd  /

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