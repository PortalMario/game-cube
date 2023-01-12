# Introduction
# About This Project
This project shares and documents my journey in creating a "Linux-GCN-Appliance" sleeper pc for the best possible user gaming experience.

**It aims to be a monument for my dear brother: TJW. Therefore, I dedicate this project to him.**

# Goals
**The overall goal is to play GCN games in enhanced high quality on a daily basis with minimal efforts and the best possible user experience that comes as close as possible to the original. The software and the documentation should be used to create a kind of "sleeper pc" within an original GameCube case while preserving/enhancing all important features of the case like the controller ports or the powerbutton.**

---
The base plan is to use the latest Ubuntu Desktop release together with retropie and dolphin. The OS should then be highly customized to increase boot time and to aim for the most accurate original GCN boot sequence. In addition, all games should be equipped with the best possible configuration and without any Bugs or possible Framedrops. Also, they need to be playable with original controller hardware. 

## 1. Software Procedure

**Note: The software part of the documentation explains how each step of the script is achieved in a non-script way providing explanations to reproduce/build your own system.**

1. 
    The system's startup should to be as close to the original GameCube boot experience as possible. To achieve this, we need a custom boot screen animation for ubuntu as well as a highly customized boot/autostart behavior. 

2. 
    Once those steps are done right, we want to autologin into the system and autostart graphical applications like the boot screen animation or the emulator frontend without any console text output shown to the user. (As we want to achieve the best user experience)

3.
    Support for original GameCube controllers need to be added so games can be played in the way they should be.

4. 
    Retropie and dolphin need to be installed and configured to serve the most comfortable user experience. The games should also be pre-configured within dolphin to get the best possible gaming experience.

5.  
    X11 needs to be configured to automatically display the boot animation and the emulator frontend. At last, the automatically logged in user needs to be configured to autostart x11 server after the autologin.

    **Note:** we will configure x11 to only use the first HDMI port on the system to be as compatible as possible with TV's.

### The main priorities/conditions for each game are:
1. Free of graphical emulation bugs.
    - If a game fails to achieve this, the game will be disqualified for the project. (With some exceptions)
2. Not under 30FPS but aiming for 60FPS without any Framedrops.
    - If stability is uncertain 30FPS will be preferred in some cases.
    - If a game just has to many Framedrops, the game will be disqualified for the project. (With some exceptions)
3. Graphics: 1080p with VSync and MSAA x4.
    - When games can’t achieve the above two priorities in 1080p they get disqualified.
4. 16:9 Aspect ratio without stretching.
    - 4:3 will be used if 16:9 is not possible.

**Those priorities are considered and checked for each game in this specific order.**

## 2. Hardware Procedure
1.  
    The original hardware of the GameCube gets replaced by a new powerful PC with onboard graphics within the CPU. The case needs to be modified for that.

2.
    The original case fan should be replaced in order to handle the new heat from the new powerful CPU.

3.
    The original powerbutton of the GameCube should be used to power on the pc itself.

4.
    Original controller ports should be enhanced/replaced to be directly usable with the PC. By doing so, controllers can be plugged in the front of the case just like they should.

5.
    The original powerlight of the GameCube should be replaced with a custom LED light that serves as the new powerlight.

6.
    The case should be kept as original as possible while housing the new pc inside.

7.
    The case should provide the best possible user experience that gets as close to the original hardware as possible. The system should also be cleaned of any kind of dirt and dust.

# How to read through this documentation
Please read the whole article before you start working on something.
Just follow the sequential numbering through directories and filenames. The next thing to read after this article is: `1.1.1 - System Boot Time.md` 
```
1 - Software
    -> 1.1 - System Boot Configuration
        -> 1.1.1 - System Boot Time.md
```
