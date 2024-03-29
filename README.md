# Obsidian

Obsidian is an EmulationStation theme for RetroPie.

```
based on art-book by anthonycaccese - https://github.com/anthonycaccese/es-theme-art-book
based on carbon v2.5 - 2020-11-17 by Tomaz
based on carbon v2.4 by Rookervik
based on simple(c) Nils Bonenberger - nilsbyte@nilsbyte.de - http://blog.nilsbyte.de/
For use with EmulationStation (http://www.emulationstation.org/)
```
See [Carbon's CHANGELOG](./CARBON_CHANGELOG.txt) for details regarding the Carbon Theme.



## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Launch Images](#launch-images)
- [Customization](#customization)
- [Attributions](#attributions)


## Features

The theme supports RetroPie/EmulationStation's 4 gamelist view style in a 16:9 aspect ratio.

- Basic
- Detailed
- Video
- Grid


### System View

**Default Platform**

Uses colorful platform logos.

![Systems View - Platform](./assets/screenshots/ui.system.platform.png)

**Custom Collection**

Supports various game collection and franchises.

![Systems View - Custom Collection](./assets/screenshots/ui.system.custom-collection.png)

**Custom System**

Adds custom systems logos (e.g. romhacks, openbor)

![Systems View - Custom System](./assets/screenshots/ui.system.custom-system.png)


### Basic View

![Basic View - Scraped](./assets/screenshots/ui.basic.png)

![Basic View - Full List](./assets/screenshots/ui.basic.snes.png)

![Basic View - Custom Collection](./assets/screenshots/ui.basic.sf.png)

### Detailed View

![Detailed View - Scraped](./assets/screenshots/ui.detailed.png)

### Video View

Same as detailed view, but a video will play in the background after a delay (requires scraping video).

[TODO: gif file here]

### Grid View

![Grid View - Screenshot](./assets/screenshots/ui.grid.scraped.png)

![Grid View - Screenshot](./assets/screenshots/ui.grid.romhacks.png)

![Grid View - Screenshot](./assets/screenshots/ui.grid.romhacks.alt.png)


## Installation

**Using Git**:

```bash
cd ~/.emulationstation/themes
git clone --depth=1 git@github.com:lioneil/obsidian-es-theme.git obsidian
```

**Manual installation**:

- Download the [latest](#todo-download-link) zip file (master branch will always be the latest stable release). 
- Extract the contents to `/home/<user>/.emulationstation/themes/obsidian/` directory.

See other [releases](#todo-releases-link).


## Launch Images

> This feature is optional. See the section about installing Launch Images if you want this feature.

The theme can add custom launch images per system in place of the default runcommand screen. The runcommand screen is RetroPie's script responsible to launch your emulators/games. This screen shows the runcommand's configurations and features.

Here is the default runcommand screen:

![Runcommand Default](./assets/screenshots/launching-default.png)

Here is the theme's replacement launch image for NeoGeo:

![Neogeo Launch Menu](./assets/launching/neogeo/launching.png)

Make sure "Launch menu art" is Disabled. In EmulationStation, go to RetroPie Setup > configuration / tools > runcommand. Set "Launch meu art" to Disabled. Otherwise the game's scraped box art will show up on the runcommand screen. More details about Launch Menu can be found in the [RetroPie docs](https://retropie.org.uk/docs/Runcommand/#adding-custom-launching-images).


### Installing Launch Images

Run the script `install-launch-images.sh` included in this theme.

```bash
cd ~/.emulationstation/themes/obsidian # or wherever you installed the theme.
chmod a+x .bin/install-launch-images.sh # to allow it to execute under your user
.bin/install-launch-images.sh # run it
```

The script will simply copy files from `./assets/launchers/` to `/opt/retropie/configs/`. Check the script included in this theme for the code.

There is also an uninstall script which simply removes all `/opt/retropie/configs/*/launching.png` files.

```bash
cd ~/.emulationstation/themes/obsidian # or wherever you installed the theme.
chmod a+x .bin/uninstall-launch-images.sh
.bin/uninstall-launch-images.sh
```

And of course, you can always just manually copy the files from `./assets/launching/` and paste them in `/opt/retropie/configs/`.


## Attributions

- System logos directly copied from [carbon theme](https://github.com/RetroPie/es-theme-carbon-2021)
- Additional system, platform, and console logos from [Dan Patrick](https://archive.org/details/console-logos-professionally-redrawn-plus-official-versions)  
- [Bootleg Games](./bootlegs/marquee.png) logo created by me.
- "ROM" text in [ROMHacks](./romhacks/marquee.png) logo generated from <a href="https://www.textstudio.com/">Text Studio</a>
- "Hacks" text in [ROMHacks](./romhacks/marquee.png) logo used Lazer '84 Font - a free font inspired in 80's. Designed by [Juan Hodgson](https://www.behance.net/gallery/31261857/LAZER-84-Free-Font).
