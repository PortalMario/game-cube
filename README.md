# Game-Cube 🎮

#### **I dedicate this project to my dear brother: TJW.**

---

[![Lint Pull Requests targeting main](https://github.com/PortalMario/game-cube/actions/workflows/shellcheck_main-pr-linter.yml/badge.svg)](https://github.com/PortalMario/game-cube/actions/workflows/shellcheck_main-pr-linter.yml)

A project that will transform an Ubuntu Desktop 22.04 LTS into a "Game-Cube" sleeper pc appliance powered by RetroPie and Dolphin. The project guide/documentation explains in detail how to create a sleeper PC that is housed within an original GameCube case to create the best possible GameCube gaming experience but with graphical enhancements for the best possible look. The project provides a script which transforms an existing pc into the mentioned appliance with guides and deep dives that helps you to build your own custom sleeper gaming appliance for any retropie supported platform.

## Game Default Features if achievable
```
Game Resolution:        1080p
Framerate:              60Hz/FPS 
MSAA ( Antialiasing ):  x4
VSync:                  Active
```

## Project Features 💡
- Completely silent boot
- Highly decreased boot time
- Customizable boot animation
- Customized emulationstation
- Preconfigured/optimized dolphin installation
- Preconfigured/optimized dolphin game settings
- Full 4-Player controller support
- Detailed software [documentation](https://github.com/PortalMario/game-cube/wiki) which explains/helps in building a custom retropie appliance.
- **Detailed [building guide](https://github.com/PortalMario/game-cube/wiki) to build an actual game-cube sleeper pc appliance!**

### Side Note
It is currently not possible to revert the changes made by the script. Keep in mind that you have to reinstall your OS completely if you want to remove changes done by the script.

## Requirements ✒
- Stable internet connection.
- A powerful [APU](./docs/2%20-%20Hardware/2.1%20-%20Requirements%20and%20Teardown/2.1.1%20-%20Hardware%20Requirements.md). (Or dedicated GPU like the a GTX 1070 and a decent four core CPU like the i5 6600K.)
- A primary username that was created during the installation of the system without any special characters and not named: "game-cube".
- At least 80GB of free storage.
- Ubuntu Desktop Minimal 22.04 LTS no Proprietary/Additional drivers installed during installation!
- GCN USB adapter and GCN controller.
- Placed custom bootscreen animation mp4-file located at: `game-cube/media/gcn.mp4` (Inside the repo)
- Placed [box covers arts](./docs/1%20-%20Software/1.2%20-%20Software%20Installation%20and%20Configuration/1.2.5%20-%20Game%20Box%20Cover%20Arts.md) of the games (listed below at "Supported Games") at
  `media/snake_case_name_of_game.jpg` (Inside the repo)

## Usage
You have to execute the script within the graphical ubuntu desktop as the primary user that was created during the initial ubuntu installation. Exec via SSH is only for advanced users. (However, a bit of basic Linux knowledge is required.)
```
cd game-cube
sudo bash game-cube.sh
```
Once the script is done, you have the place your games in the correct folder (`/home/<PRIMARY_USER>/RetroPie/roms/gc`). Make sure the games have the correct ownership! (PRIMARY_USER)

Make sure the games are exactly named after the following scheme:
`game_name_without_any_special_chars.iso` (Replace "game_name_without_any_special_chars" with the correct/exact snake case name from the "Supported Games" list below) 

NOTE: You can’t put whitespaces or special characters like `'` in the filename. Therefore, you should remove any special characters and replace whitespaces with underscores. Also, make sure everything is snake case. e.g.: Disney's Donald Duck PK -> disneys_donald_duck_pk.iso

If you’re unsure if the filename of the game is correct, look at `files/gamelist.xml` at the "Path" parameter and make sure you matched it exactly for each game. There you can also make sure how to name/store the box cover arts correctly.

# [Documentation](https://github.com/PortalMario/game-cube/wiki)
Part of this project was also to create a documentation that covers everything I’ve done/learned along the way. It covers every technology and the building process of the actual hardware in detail, so everyone could build their own sleeper pc console appliance. For example: if someone wants to do the same but for another retropie supported platform, this guide helps in achieving that. It also covers many useful information regarding a customized Linux boot process. I highly encourage/recommend people to take a look at it! You can find it [here](https://github.com/PortalMario/game-cube/wiki).

# Supported Games (PAL-DE) 👾
These games are optimized and configured for the best possible experience. (The out commented ones will be optimized in future updates).
```
Disney's Donald Duck PK
Eternal Darkness - Sanity's Requiem
F-Zero GX
# Luigi's Mansion
Mario Golf - Toadstool Tour
Mario Kart - Double Dash
Mario Party 4
Mario Party 5
Mario Party 6
Mario Smash Football
Metroid Prime
Paper Mario - Die Legende vom Äonentor
Pikmin 2
Pikmin
# Pokemon XD - Gale of Darkness
# SSX On Tour
Super Smash Bros. Melee
The Legend of Zelda - Collector's Edition
The Legend of Zelda - The Wind Waker
# The Legend of Zelda - Twilight Princess
# Wario World
```
----------------------
## Credits | Copyright Notice
I do not hope to violate any copyrights, licenses, trademarks or patents with my work neither do i intend in making any profit or distributing any copyrighted material. I chose the MIT-License just to make my work "open source" and accessible/usable to everyone. **This project is intended for fun and joy and should be considered as a monument for my dear brother: TJW.**

All rights regarding the name of the videogames as well as the name of the videogame consoles belong completely to Nintendo and the corresponding developers/publishers. I do not own any content created by Nintendo and/or the corresponding developers/publishers, it belongs to them. 

Credits/Rights go to: RetroPie, Nintendo and/or the corresponding developers/publishers, Dolphin, Libretro, Retroarch, ToadKing and/or any other party for their corresponding property.
