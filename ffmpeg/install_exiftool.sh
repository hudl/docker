apt-get install -y perl-ExtUtils-MakeMaker

curl -L http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-9.84.tar.gz | tar zxf -
if [ $? -ne 0 ]; then echo "exiftool download failed"; exit 1; fi
cd Image-ExifTool-9.84
perl Makefile.PL
make && make install
cd ..
rm -rf Image-ExifTool-9.84