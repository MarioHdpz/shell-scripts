#!/bin/bash

DIR='/opt/rambox'

# Remove existing Rambox if exists
if [ -d "$DIR" ]; then  
    sudo rm -rf /opt/rambox
    sudo rm -rf /usr/share/applications/rambox.desktop
fi

# Create install dir
sudo mkdir -p /opt/rambox

#install Rambox
wget -qO- https://getrambox.herokuapp.com/download/linux_64?filetype=deb | sudo tar xvz -C /opt/rambox/ --strip-components 1

# Add app icon
sudo wget "https://raw.githubusercontent.com/saenzramiro/rambox/master/resources/Icon.png" -O /opt/rambox/rambox-icon.png

# Configure Desktop Entry
sudo bash -c "cat <<EOF > /usr/share/applications/rambox.desktop                                                                 
[Desktop Entry]
Name=Rambox
Comment=
Exec=/opt/rambox/rambox
Icon=/opt/rambox/rambox-icon.png
Terminal=false
Type=Application
Categories=Messaging,Social
EOF"
