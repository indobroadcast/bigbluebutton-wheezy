#!/bin/bash
#
## Autoinstaller The Latest BigBlueButton 0.81 in Debian 7 Wheezy By Bernard Situmeang [Email: admin@indobroadcast.com]
## 
#
# Add the BigBlueButton key
wget http://ubuntu.bigbluebutton.org/bigbluebutton.asc -O- | sudo apt-key add -
#
# Add the BigBlueButton repository URL && Wheezy Backport
echo "deb http://ubuntu.bigbluebutton.org/lucid_dev_081/ bigbluebutton-lucid main" | sudo tee /etc/apt/sources.list.d/bigbluebutton.list
#
echo "deb http://ftp.de.debian.org/debian wheezy main contrib non-free" | sudo tee /etc/apt/sources.list
echo "deb http://ftp.de.debian.org/debian wheezy-backports main contrib non-free" | sudo tee /etc/apt/sources.list
echo "deb http://ftp.de.debian.org/debian wheezy-proposed-updates main contrib non-free" | sudo tee /etc/apt/sources.list
#
# Add multimedia source
echo "deb http://www.deb-multimedia.org wheezy main non-free" | sudo tee /etc/apt/sources.list
echo "deb http://www.deb-multimedia.org wheezy-backports main" | sudo tee /etc/apt/sources.list
#
#
apt-get update
apt-get -y -f install sudo aptitude subversion dpkg-dev debhelper dh-make devscripts fakeroot deb-multimedia-keyring
sudo aptitude -y -f dist-upgrade
#
sudo aptitude -y -f install build-essential git-core checkinstall yasm texi2html libopencore-amrnb-dev \
libopencore-amrwb-dev libsdl1.2-dev libtheora-dev libvorbis-dev libx11-dev libxfixes-dev libxvidcore-dev zlib1g-dev
#	
sudo aptitude -y -f install libfaad-dev faad faac libfaac0 libfaac-dev libmp3lame-dev x264 libx264-dev libxvidcore-dev \
build-essential checkinstall libffi5 subversion libmpfr4 libmpfr-dev ffmpeg
sudo aptitude -y -f install
#
#
# Copy file for fixing depedency
cd /var/cache/apt/archives
wget http://ftp.us.debian.org/debian/pool/main/g/gmp/libgmp3c2_4.3.2+dfsg-1_amd64.deb
wget http://free.nchc.org.tw/ubuntu//pool/main/m/mpfr/libmpfr1ldbl_2.4.2-3ubuntu1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb
#
sudo dpkg -i libgmp3c2_4.3.2+dfsg-1_amd64.deb libmpfr1ldbl_2.4.2-3ubuntu1_amd64.deb libssl0.9.8_0.9.8o-4squeeze14_amd64.deb
sudo aptitude -y -f install
#
# Copy file sun-java6 & depedency
cd /var/cache/apt/archives
wget http://ftp.us.debian.org/debian/pool/non-free/s/sun-java6/ia32-sun-java6-bin_6.26-0squeeze1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/sun-java6/sun-java6-bin_6.26-0squeeze1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/sun-java6/sun-java6-jdk_6.26-0squeeze1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/sun-java6/sun-java6-jre_6.26-0squeeze1_all.deb
#
cd /var/cache/apt/archives
wget http://ftp.us.debian.org/debian/pool/main/i/ia32-libs/ia32-libs-i386_0.4_i386.deb
wget http://ftp.us.debian.org/debian/pool/main/i/ia32-libs/ia32-libs_20140131_amd64.deb
wget http://ftp.us.debian.org/debian/pool/main/e/eglibc/libc6-i386_2.11.3-4_amd64.deb
wget http://ftp.us.debian.org/debian/pool/main/e/eglibc/libc6_2.11.3-4_amd64.deb
wget http://ftp.us.debian.org/debian/pool/main/e/eglibc/libc6-i686_2.11.3-4_i386.deb
#
cd /var/cache/apt/archives
dpkg -i ia32-libs-i386_0.4_i386.deb ia32-libs_20140131_amd64.deb libc6-i386_2.11.3-4_amd64.deb libc6_2.11.3-4_amd64.deb libc6-i686_2.11.3-4_i386.deb
dpkg -i ia32-sun-java6-bin_6.26-0squeeze1_amd64.deb sun-java6-bin_6.26-0squeeze1_amd64.deb 
dpkg -i sun-java6-jdk_6.26-0squeeze1_amd64.deb sun-java6-jre_6.26-0squeeze1_all.deb
#
sudo aptitude -y -f install openjdk-6-jdk sun-java6-jdk sun-java6-jre && sudo aptitude -y -f install
#
# Install Flash plugin
sudo aptitude -y -f install flashplugin-nonfree
#
sudo aptitude update
sudo aptitude -y -f dist-upgrade
#
# Build-dep JAVA & PHP5 & Python & Ruby for ruby1.9.2_1.9.2-p290
sudo aptitude -y -f build-dep php5
sudo aptitude -y -f build-dep python
sudo aptitude -y -f build-dep ruby
sudo aptitude -y -f build-dep java-package
#
sudo service apache2 stop && sudo aptitude -y -f --purge remove apache2
sudo aptitude -y -f install nginx nginx-common nginx-full 
sudo service nginx restart
#
# Install The Latest Libreoffice via backport
sudo aptitude -y -t wheezy-backports install libreoffice libreoffice-common libreoffice-gnome
sudo aptitude -y -f dist-upgrade && sudo apt-get -y -f install
#
#
cd /usr/local/src
wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p290.tar.gz
tar xvzf ruby-1.9.2-p290.tar.gz
cd ruby-1.9.2-p290
#
./configure --prefix=/usr\
          --program-suffix=1.9.2\
          --with-ruby-version=1.9.2\
          --disable-install-doc
#
sudo make
#
sudo checkinstall -D -y\
	                  --fstrans=no\
	                  --nodoc\
	                  --pkgname='ruby1.9.2'\
	                  --pkgversion='1.9.2-p290'\
	                  --provides='ruby'\
	                  --requires='libc6,libffi5,libgdbm3,libncurses5,libreadline5,openssl,libyaml-0-2,zlib1g'\
	                  --maintainer=brendan.ribera@gmail.com
#
sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.2 500 \
	                         --slave /usr/bin/ri ri /usr/bin/ri1.9.2 \
	                         --slave /usr/bin/irb irb /usr/bin/irb1.9.2 \
	                         --slave /usr/bin/erb erb /usr/bin/erb1.9.2 \
	                         --slave /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.2                
sudo update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.2 500
#
sudo gem install rubygems-update -v 1.3.7
#
# Install All Needed Gems
sudo gem install rubygems-update -v 1.3.7
sudo gem install builder -v '2.1.2' -- --with-cflags=-w --nodoc
sudo gem install cucumber -v '0.9.2' -- --with-cflags=-w --nodoc
sudo gem install json -v '1.4.6' -- --with-cflags=-w --nodoc
sudo gem install diff-lcs -v '1.1.2' -- --with-cflags=-w   --nodoc
sudo gem install term-ansicolor -v '1.0.5' -- --with-cflags=-w --nodoc
sudo gem install gherkin -v '2.2.9' -- --with-cflags=-w --nodoc
sudo gem install god -v '0.13.3' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install addressable -v '2.3.5' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install fastimage -v '1.6.1' -- --with-cflags=-w --disable-install-doc --nodoc
#
sudo gem install curb -v '0.7.15' -- --with-cflags=-w --nodoc
sudo gem install mime-types -v '1.16' -- --with-cflags=-w --nodoc
sudo gem install nokogiri -v '1.4.4' -- --with-cflags=-w --nodoc
sudo gem install open4 -v '1.3' -- --with-cflags=-w --nodoc
sudo gem install rack -v '1.2.2' -- --with-cflags=-w --nodoc
sudo gem install redis -v '2.1.1' -- --with-cflags=-w --nodoc
sudo gem install redis-namespace -v '0.10.0' -- --with-cflags=-w --nodoc
sudo gem install tilt -v '1.2.2' -- --with-cflags=-w --nodoc
sudo gem install sinatra -v '1.2.1' -- --with-cflags=-w --nodoc
sudo gem install vegas -v '0.1.8' -- --with-cflags=-w --nodoc
sudo gem install resque -v '1.15.0' -- --with-cflags=-w --nodoc
sudo gem install rspec-core -v '2.0.0' -- --with-cflags=-w
sudo gem install rspec-expectations -v '2.0.0' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install rspec-mocks -v '2.0.0' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install rspec -v '2.0.0' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install rubyzip -v '0.9.4' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install streamio-ffmpeg -v '0.7.8' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install trollop -v '1.16.2' -- --with-cflags=-w --disable-install-doc --nodoc
#
# Install Optional Gems
sudo gem install rails -v '2.3.5' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install bundler -v '1.5.3' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install mysql -v '2.8.1' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install rake -v '0.8.7' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install activesupport -v '2.3.5' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install rack -v '1.0.1' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install actionpack -v '2.3.5' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install actionmailer -v '2.3.5' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install activerecord -v '2.3.5' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install activeresource -v '2.3.5' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install declarative_authorization -v '0.5.1' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install fattr -v '2.2.1' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install i18n -v '0.4.2' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install session -v '3.1.0' -- --with-cflags=-w --disable-install-doc --nodoc
sudo gem install rush -v '0.6.8' -- --with-cflags=-w --disable-install-doc --nodoc
#
#
## Install BigBlueButton 0.81
#
## Step 1
#
sudo aptitude -y -f install libjpeg62-dev \
libbs2b0 liblzo2-2 libmpg123-0 libsox-fmt-alsa libsox-fmt-base libsox2 liblockfile1 \
libvorbisidec1 libx264-132 mencoder sox vorbis-tools jsvc libcommons-daemon-java
#
#
## Step 2
sudo aptitude -y -f install java-package \
authbind cabextract libcommons-dbcp-java libcommons-pool-java libecj-java \
libgeronimo-jta-1.1-spec-java libtomcat6-java netcat-openbsd openoffice.org \
ttf-mscorefonts-installer
#
#
## Step 3
sudo aptitude -y -f install bbb-record-core red5 bbb-freeswitch   
#
#
## Step 4
sudo aptitude -y -f install bbb-config \
authbind bbb-apps bbb-apps-deskshare bbb-apps-sip bbb-apps-video bbb-client bbb-config bbb-openoffice-headless \
bbb-playback-presentation bbb-web cabextract libcommons-dbcp-java libcommons-pool-java libecj-java \
libgeronimo-jta-1.1-spec-java libtomcat6-java netcat-openbsd openoffice.org redis-server-2.2.4 swftools-0.9.1 tomcat6 \
tomcat6-common bigbluebutton bbb-demo  
#
sudo aptitude -y -f install
#
sudo bbb-conf --check
sudo bbb-conf --clean
sudo bbb-conf --restart
# sudo bbb-conf --setip 192.168.1.100
#
#
#
#
##### Rebuild FFMPEG v2.0.1 Full Features  ######


# Add multimedia source
    echo "deb http://www.deb-multimedia.org wheezy main non-free" | sudo tee /etc/apt/sources.list
    echo "deb http://www.deb-multimedia.org wheezy-backports main" | sudo tee /etc/apt/sources.list

sudo apt-get update
sudo apt-get -y -f install deb-multimedia-keyring
sudo aptitude -y -f dist-upgrade

# Install FFMPEG Depedency

sudo aptitude -y -f install build-essential git-core checkinstall subversion make \
libjpeg62-dev libxext-dev ffmpeg libgnutls-dev libgnutls-openssl27 libgnutls26 \
libgnutlsxx27 libfaad-dev faad faac libfaac0 libfaac-dev libmp3lame-dev yasm texi2html \
x264 libx264-dev libxvidcore-dev libffi5 libmpfr4 libmpfr-dev libopencore-amrnb-dev \
libopencore-amrwb-dev libtheora-dev libvorbis-dev libxfixes-dev libxvidcore-dev zlib1g-dev


## installYasm 1.2.0
cd /usr/local/src
sudo wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
sudo tar xzvf yasm-1.2.0.tar.gz
cd yasm-1.2.0
sudo ./configure
sudo make
sudo checkinstall --pakdir "$HOME/Desktop" --pkgname yasm --pkgversion 1.2.0 --backup=no --default

# Setup libvpx
cd /usr/local/src
sudo git clone http://git.chromium.org/webm/libvpx.git
cd libvpx
./configure --prefix=/usr \
                --enable-shared \
                --disable-static
sudo make
sudo checkinstall --pkgname=libvpx --pkgversion="`date +%Y%m%d%H%M`-git" --backup=no --default --deldoc=yes
#
#
#Install X264
cd /usr/local/src
mkdir /usr/local/lib/pkgconfig
sudo git clone git://git.videolan.org/x264
cd x264/
sudo ./configure --enable-static --disable-opencl
sudo make
sudo checkinstall --pkgname=x264 --default --pkgversion="3:$(./version.sh | awk -F'[" ]' '/POINT/{print $4"+git"$5}')" --backup=no --deldoc=yes
#
#
# Install lame Used for MP3
cd /usr/local/src
wget http://sourceforge.net/projects/lame/files/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
sudo ./configure --enable-nasm --disable-shared
sudo make
sudo checkinstall --pkgname=lame-ffmpeg --pkgversion="3.99.5" --backup=no --default --deldoc=yes
#
#
# Fixing Depedency
wget http://ftp.us.debian.org/debian/pool/main/libv/libvpx/libvpx-dev_0.9.1-2_amd64.deb
wget http://ftp.us.debian.org/debian/pool/main/libv/libvpx/libvpx0_0.9.1-2_amd64.deb
#
sudo aptitude -y -f --purge remove libffms2-2 liblsmash1 libvpx && rm -rf /usr/lib/libvpx.so
sudo dpkg -i libvpx0_0.9.1-2_amd64.deb libvpx-dev_0.9.1-2_amd64.deb 
sudo aptitude -y -f install  libvpx-dev libvpx1 
sudo aptitude -y -f install libraw1394-dev libraw1394-tools libdc1394-22 libdc1394-22-dev
#
#
#
### Install The Latest FFMpeg from Git ###
# git clone git://source.ffmpeg.org/ffmpeg.git
# cd ffmpeg
#
#
### Install FFMPEG v2.0.1 ###
# cd /usr/local/src
# mkdir /usr/local/share/ffmpeg
# wget http://ffmpeg.org/releases/ffmpeg-2.0.1.tar.gz
# tar -xvzf ffmpeg-2.0.1.tar.gz
# cd ffmpeg-2.0.1
# 
#
### Install FFMPEG v2.1 |  28-Oct-2013 02:11 ###
# wget http://ffmpeg.org/releases/ffmpeg-2.1.tar.gz
# tar xzvf ffmpeg-2.1.tar.gz
# cd ffmpeg-2.1
#	
#
# Install FFMPEG v2.2-rc1 |  01-Mar-2014 04:27
wget http://ffmpeg.org/releases/ffmpeg-2.2-rc1.tar.gz
ar xzvf ffmpeg-2.2-rc1.tar.gz
cd ffmpeg-2.2-rc1
#
#
# Full build
./configure --enable-gpl --enable-postproc --enable-swscale --enable-pthreads --enable-x11grab \
--enable-libdc1394 --enable-libfaac --enable-libgsm --enable-libmp3lame --enable-libtheora \
--enable-libvorbis --enable-libx264 --enable-libxvid --enable-nonfree --enable-version3 \
--enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libvpx
#
sudo make
sudo checkinstall --pkgname=ffmpeg --pkgversion="${FFMPEG_VERSION}" --backup=no --deldoc=yes --default
#
#
#
#root@indobroadcast:/usr/local/src/ffmpeg-2.0.1# ffmpeg -version
#ffmpeg version 2.2
#built on Mar  5 2014 02:16:47 with gcc 4.7 (Debian 4.7.2-5)
#configuration: --enable-gpl --enable-postproc --enable-swscale --enable-pthreads --enable-x11grab --enable-libdc1394 --enable-libfaac --enable-libgsm --enable-libmp3lame 
#--enable-libtheora --enable-libvorbis --enable-libx264 --enable-libxvid --enable-nonfree --enable-version3 --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libvpx
#libavutil      52. 38.100 / 52. 38.100
#libavcodec     55. 18.102 / 55. 18.102
#libavformat    55. 12.100 / 55. 12.100
#libavdevice    55.  3.100 / 55.  3.100
#libavfilter     3. 79.101 /  3. 79.101
#libswscale      2.  3.100 /  2.  3.100
#libswresample   0. 17.102 /  0. 17.102
#libpostproc    52.  3.100 / 52.  3.100
#
#
#
#
#
sudo service nginx restart
sudo service red5 restart
sudo service tomcat6 restart
#
sudo bbb-conf --clear
sudo bbb-conf --check
sudo bbb-conf --restart
#sudo bbb-conf --setip 192.168.1.100
#
#
# Thank you very much, for support & BBB-Hosting send info via: admin@indobroadcast.com
# Best Regards, Bernard Situmeang


