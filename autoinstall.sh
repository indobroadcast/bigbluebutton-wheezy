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
#
#
#
# Copy file for fixing depedency
cd /var/cache/apt/archives
wget http://ftp.us.debian.org/debian/pool/main/g/gmp/libgmp3c2_4.3.2+dfsg-1_amd64.deb
wget http://free.nchc.org.tw/ubuntu//pool/main/m/mpfr/libmpfr1ldbl_2.4.2-3ubuntu1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb
#
sudo dpkg -i libgmp3c2_4.3.2+dfsg-1_amd64.deb libmpfr1ldbl_2.4.2-3ubuntu1_amd64.deb libssl0.9.8_0.9.8o-4squeeze14_amd64.deb
#

#
# Copy file sun-java6
wget http://ftp.us.debian.org/debian/pool/non-free/s/sun-java6/ia32-sun-java6-bin_6.26-0squeeze1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/sun-java6/sun-java6-bin_6.26-0squeeze1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/sun-java6/sun-java6-jdk_6.26-0squeeze1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/sun-java6/sun-java6-jre_6.26-0squeeze1_all.deb
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
sudo service apache2 stop
sudo aptitude -y -f install nginx nginx-common nginx-full 
sudo service nginx restart

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




