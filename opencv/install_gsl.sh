cd  /

curl -L http://gnu.mirrorcatalogs.com/gsl/gsl-1.16.tar.gz | tar zxf -
if [ $? -ne 0 ]; then echo "gsl download failed"; exit 1; fi
cd gsl-1.16
./configure
make && make install
ldconfig
cd ..
rm -rf gsl-1.16