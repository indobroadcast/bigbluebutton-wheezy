## Autoinstaller The Latest BigBlueButton 0.81 in Debian 7 Wheezy By Bernard Situmeang [Email: admin@indobroadcast.com]

sudo aptitude update
sudo aptitude -y -f dist-upgrade

# Add the BigBlueButton key
wget http://ubuntu.bigbluebutton.org/bigbluebutton.asc -O- | sudo apt-key add -

# Add the BigBlueButton repository URL
echo "deb http://ubuntu.bigbluebutton.org/lucid_dev_081/ bigbluebutton-lucid main" | sudo tee /etc/apt/sources.list.d/bigbluebutton.list

# Install Flash plugin
sudo aptitude -y -f install flashplugin-nonfree

# Build-dep JAVA & PHP5 & Python & Ruby for ruby1.9.2_1.9.2-p290
sudo aptitude -y -f build-dep php5
sudo aptitude -y -f build-dep python
sudo aptitude -y -f build-dep ruby
sudo aptitude -y -f build-dep java-package
