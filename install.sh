# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
else
	read -p "Version to install: " ver
	apt install build-essential cmake pkg-config -y
	apt install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev -y
	apt install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev -y
	apt install libxvidcore-dev libx264-dev -y
	apt install libatlas-base-dev gfortran -y
	apt install install python2.7-dev python3-dev -y
	cd ~
	cv="https://github.com/Itseez/opencv/archive/$ver.zip"
	echo $cv
	wget -O opencv.zip $cv
	unzip opencv.zip
	cntrb="https://github.com/Itseez/opencv_contrib/archive/$ver.zip"
	wget -O opencv_contrib.zip $cntrb
	unzip opencv_contrib.zip
	wget https://bootstrap.pypa.io/get-pip.py
	sudo python get-pip.py
	sudo python3 get-pip.py
	pip install numpy
	cd ~/"opencv-$ver"/
	mkdir build
	cd build
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
    	-D CMAKE_INSTALL_PREFIX=/usr/local \
	    -D INSTALL_PYTHON_EXAMPLES=ON \
	    -D OPENCV_EXTRA_MODULES_PATH=~/"opencv_contrib-$ver"/modules \
	    -D BUILD_EXAMPLES=ON ..
	make -j4
	make install
fi
echo -e "\e[44m\e[5mThank You for Using this tool...\e[0m"


