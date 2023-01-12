#!/bin/bash

# Set workdir and user.
WORKDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
# shellcheck disable=SC2012
PRIMARY_USER=$(ls -l /opt/retropie/configs/gc | awk '{print $3}' | uniq | tail -n1)

update_dolphin () {
    echo -e "\nUpdating dolphin configuration..."
    cd "$WORKDIR" || exit
    cp files/Dolphin.ini /opt/retropie/configs/gc/Config/Dolphin.ini
    # Add basic config for controller to load custom profile.
    cp files/GCPadNew.ini /opt/retropie/configs/gc/Config/GCPadNew.ini
    # Add custom profiles for wii u gc adapter ports.
    mkdir -p /opt/retropie/configs/gc/Config/Profiles/GCPad
    cp files/default_* /opt/retropie/configs/gc/Config/Profiles/GCPad/
    echo "Dolphin configuration updated."
}

update_dolphin_games () {
    cd "$WORKDIR" || exit
    echo -e "\nUpdating/Configuring GCN games..."

    # Game specific Configuration.
    mkdir -p /opt/retropie/configs/gc/GameSettings/
    cp -r gameINI/* /opt/retropie/configs/gc/GameSettings/

    # Game Boxart.
    cp files/gamelist.xml "/home/${PRIMARY_USER}/RetroPie/roms/gc/" && chown -R "$PRIMARY_USER":"$PRIMARY_USER" "/home/${PRIMARY_USER}/RetroPie/roms/gc/"
    cp -r media/*.jpg /srv/media && chown -R "$PRIMARY_USER":"$PRIMARY_USER" /srv/
    echo "GCN configuration updated."
}

# Check for sudo priv.
if [ "$USER" != "root" ]; then
    echo "You need to be root."
    exit 1
fi

if update_dolphin; then
    if update_dolphin_games; then
        chown -R "$PRIMARY_USER":"$PRIMARY_USER" /opt/retropie/configs/gc
        echo "Dolphin configuration successfully done!"
    else
        echo "Error during dolphin configuration."
        exit
    fi
else
    echo "Error during dolphin game configuration."
    exit
fi