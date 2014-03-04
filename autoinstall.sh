## Autoinstaller The Latest BigBlueButton 0.81 in Debian 7 Wheezy By Bernard Situmeang [Email: admin@indobroadcast.com]

sudo aptitude update
sudo aptitude -y -f dist-upgrade

# Add the BigBlueButton key
wget http://ubuntu.bigbluebutton.org/bigbluebutton.asc -O- | sudo apt-key add -

# Add the BigBlueButton repository URL
echo "deb http://ubuntu.bigbluebutton.org/lucid_dev_081/ bigbluebutton-lucid main" | sudo tee /etc/apt/sources.list.d/bigbluebutton.list
