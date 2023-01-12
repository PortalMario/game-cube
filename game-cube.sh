#!/bin/bash
# Script will transform an Ubuntu Desktop 22.04 into the ultimate "Game-Cube" powered by RetroPie.

# Display Requirements/Welcome.
welcome_requirements () {
    echo -e "#################################"
    echo -e "######      !WARNING!      ######"
    echo -e "#################################"
    echo -e "\n This script will transform your computer into a retropie/dolphin appliance!"
    echo -e " This cannot be reverted at the moment, so please keep in mind that you have to"
    echo -e " reinstall your entire OS if you want to remove the changes made by this script.\n"


    echo -e "#################################"
    echo -e "###### Game-Cube Installer ######"
    echo -e "#################################"
    echo -e "\n Make sure your system meets the following requirements: "
    echo -e "  - Stable internet connection."
    echo -e "  - A powerful APU."
    echo -e "  - A primary username that was created during the installation of the system without"
    echo -e "    any special characters and not named: 'game-cube'"
    echo -e "  - At least 80GB of free storage"
    echo -e "  - Custom bootscreen animation mp4-file located at: game-cube/media/gcn.mp4"
    echo -e "  - Placed box covers arts of the games (listed within files/gamelist.xml) at"
    echo -e "    media/snake_case_name_of_game.jpg\n"

    read -r -p "Does the system meet all the requirements to start the installation? (yes/no): " CHOICE
    case "${CHOICE}" in
        yes)
            echo "Starting installation..." ; sleep 4
        ;;
        no)
            echo "Aborting..."
            exit 100
        ;;
        *)
            echo 'Aborting... Please type "yes" or "no"'
            exit 100
        ;;
    esac

    # Update system and install dependencies.
    update_dependencies
}

# Display finish message after successfull installation.
finish () {
    echo -e "\n\nGame-Cube installation sucessfully done!"
    echo "Copy your games to: /home/${PRIMARY_USER}/RetroPie/roms/gc"
    echo -e "\nOnce your done, connect your GCN adapter and reboot your system."
}

# Update system and install depends.
update_dependencies () {
    echo -e "Updating system and installing dependencies..." ; sleep 4
    export DEBIAN_FRONTEND=noninteractive
    if apt update && apt full-upgrade -y && apt install matchbox-window-manager make mpv git xorg dialog unzip xmlstarlet -y ; then
        apt autoremove -y
        echo -e "System update and installation of dependencies done! \n"
    else
        echo -e "ERROR: System update and installation of dependencies failed!\n"
        exit 1
    fi
}

# Silent boot, and CLI-boot.
customize_boot () {
    echo -e "\nCustomizing boot behaviour..." ; sleep 4

    # Disable services. (Increase Boot-Time) (systemd-analyze critical-chain mulit-user.target)
    systemctl disable snapd.service plymouth.service snapd.seeded.service NetworkManager-wait-online.service
    systemctl mask snapd.service plymouth.service snapd.seeded.service NetworkManager-wait-online.service
    apt purge snapd -y > /dev/null 2>&1
    sed -i '0,/localhost/s//localhost '"$(hostname)"'/' /etc/hosts

    # Boot to cli.
    systemctl set-default multi-user.target

    # Configure silent boot.
    sed -i -e 's/GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=0 vt.global_cursor_default=0 fsck.mode=skip nowatchdog console=ttyS0"/g' /etc/default/grub
    update-grub
}

# Configure automatic cli login. 
autologin () {
    echo -e "\nConfiguring autologin..." ; sleep 4
    cd "$WORKDIR" || exit
    # User input for primary username.
    read -r -p "Please enter the primary username of the system: " PRIMARY_USER
    if grep "$PRIMARY_USER" /etc/passwd > /dev/null 2>&1 ; then
        echo -e "Primary username: ${PRIMARY_USER}\n"
    else
        echo -e "ERROR: Username not found."
        exit 2
    fi

    # silent autologin.
    touch "/home/${PRIMARY_USER}/.hushlogin"
    chown "$PRIMARY_USER":"$PRIMARY_USER" "/home/${PRIMARY_USER}/.hushlogin"

    # Configure autologin for the primary user.
    mkdir /etc/systemd/system/getty@tty1.service.d/
    cp files/override.conf /etc/systemd/system/getty@tty1.service.d/
    chown -R root:root /etc/systemd/system/getty@tty1.service.d/
    chmod -R 644 /etc/systemd/system/getty@tty1.service.d/override.conf
    # Replace "User" with the correct autologin exec.
    sed -i -e 's/USER/'"${PRIMARY_USER}"'/g' /etc/systemd/system/getty@tty1.service.d/override.conf
    systemctl daemon-reload
}

# Configure bashrc/xinitrc to load custom "boot-screen" and emulationsation.
configure_autostart_and_screen () {
    cd "$WORKDIR" || exit
    # Configure xinitrc.
    cp files/xinitrc /etc/X11/xinit/xinitrc
    chmod 755 /etc/X11/xinit/xinitrc

    # Copy GCN boot screen.
    mkdir /srv/media && chown -R "$PRIMARY_USER":"$PRIMARY_USER" /srv/media
    cp media/gcn.mp4 /srv/media
    chmod 777 /srv/media/gcn.mp4

    # Configure .bashrc for primary user to launch startx.
    cp files/.bashrc "/home/${PRIMARY_USER}"
    chown "$PRIMARY_USER":"$PRIMARY_USER" "/home/${PRIMARY_USER}/.bashrc"
    chmod 644 "/home/${PRIMARY_USER}/.bashrc"
    echo -e "Autostart configuration for GCN-Intro and ES done."
}

# Install wii-u-gc-adapter support.
wii-u-gc-adapter () {
    echo -e "\nAdding/Installing wii-u-gc-adapter support... " ; sleep 4
    cd "$WORKDIR" || exit 
    # Create Systemd service.
    cp files/wii-u-gcn-controller-adapter.service /etc/systemd/system/
    systemctl enable /etc/systemd/system/wii-u-gcn-controller-adapter.service

    # Install custom driver.
    cd /tmp || exit
    git clone https://github.com/ToadKing/wii-u-gc-adapter.git && cd wii-u-gc-adapter || exit
    make || exit 22
    cp wii-u-gc-adapter /srv/
    echo -e "Implementation of wii-u-gc-adapter support finished."
}

# Installing retropie and dolphin.
install_retropie_dolphin () {
    echo -e "\nStarting RetroPie installation. This will take some time, so grab a coffee... (~45 minutes)\n" ; sleep 4
    cd "/home/${PRIMARY_USER}" || exit
    git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
    cd RetroPie-Setup || exit
    __nodialog=1 ./retropie_packages.sh setup basic_install
    __nodialog=1 ./retropie_packages.sh dolphin
    echo -e "RetroPie installation Done!\n"
}

# Configure retropie and dolphin.
configure_retropie_dolphin () {
    echo -e "\nConfiguring retropie and dolphin..."
    # Disable runcommand-menu.
    sed -i -e 's/disable_menu.*/disable_menu = "1"/g' /opt/retropie/configs/all/runcommand.cfg
    sed -i -e 's/image_delay.*/image_delay = "1"/g' /opt/retropie/configs/all/runcommand.cfg

    # Install ES Theme.
    cd "/home/${PRIMARY_USER}/RetroPie-Setup" || exit
    __nodialog=1 ./retropie_packages.sh esthemes install_theme "eudora-bigshot" "AmadhiX"

    # Set ES Theme.
    cd "$WORKDIR" || exit
    cp files/es_settings.cfg /opt/retropie/configs/all/emulationstation/es_settings.cfg && chown -R "$PRIMARY_USER":"$PRIMARY_USER" /opt/retropie/configs/all/emulationstation 

    # Remove RetroPie menu from emulation list.
    cd "/home/${PRIMARY_USER}/RetroPie-Setup" || exit
    sudo __nodialog=1 ./retropie_packages.sh retropiemenu remove

    # Configure dolphin games.
    cd "$WORKDIR" || exit
    bash configure_dolphin.sh
}

# Configure and install Retropie & Dolphin.
retropie_dolphin () {
    if install_retropie_dolphin; then
        echo "Retropie installation successfull."
        if configure_retropie_dolphin; then
            echo "Retropie configuration successfull."
            if wii-u-gc-adapter; then
                echo "Wii-u-gc-adapter support implementation sucessfull."
            else
                echo "Error during: wii-u-gc-adapter support implementation."
                exit 
            fi
        else
            echo "Error during: RetroPie/Dolphin configuration."
            exit
        fi
    else
        echo "Error during: Retropie installation."
        exit
    fi
}

# Configure system-boot, autostart and screen.
system_setup () {
    if customize_boot; then
        echo "Boot customization successfully done."
        if autologin; then
            echo "Autologin successfully configured."
            if configure_autostart_and_screen; then
                echo "Autostart and screen configuration successfull."
            else
                echo "Error during: autostart and screen configuration."
                exit
            fi
        else
            echo "Error during: Autologin configuration."
            exit
        fi
    else
        echo "Error during: boot customization!"
        exit 
    fi

}

main () {
    if welcome_requirements; then 
        if system_setup; then
            if retropie_dolphin; then
                finish
            else
                exit 3
            fi
        else
            exit 2
        fi
    else
        exit 1
    fi
}

# Check for sudo priv.
if [ "$USER" != "root" ]; then
    echo "You need to be root."
    exit 1
fi

# Set workdir to script location.
WORKDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

main 2>&1 | tee -a game-cube.log