## Autoinstaller The Latest BigBlueButton 0.81 in Debian 7 Wheezy By Bernard Situmeang [Email: admin@indobroadcast.com]
#
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
# Copy file for fixing depedency
cd /var/cache/apt/archives
wget http://ftp.us.debian.org/debian/pool/main/g/gmp/libgmp3c2_4.3.2+dfsg-1_amd64.deb
wget http://free.nchc.org.tw/ubuntu//pool/main/m/mpfr/libmpfr1ldbl_2.4.2-3ubuntu1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb





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
# Install The Latest Libreoffice via backport
sudo aptitude -y -t wheezy-backports install libreoffice libreoffice-common libreoffice-gnome
sudo apt-get -y -f install
