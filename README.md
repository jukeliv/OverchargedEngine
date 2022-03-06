# Friday Night Funkin Overcharged Engine
![](https://raw.githubusercontent.com/susyboy23/OverchargedEngine/main/art/OverchargedEngineLogoNew.png)

ninjamuffin99: **IF YOU MAKE A MOD AND DISTRIBUTE A MODIFIED / RECOMPILED VERSION, YOU MUST OPEN SOURCE YOUR MOD AS WELL**

## Special Thanks

- [ninjamuffin99](https://twitter.com/ninja_muffin99)
- [PhantomArcade3K](https://twitter.com/phantomarcade3k) and [Evilsk8r](https://twitter.com/evilsk8r)
- [Kawaisprite](https://twitter.com/kawaisprite)
- [ShadowMario](https://github.com/ShadowMario) and [Alan Yao](https://github.com/alanyao)
- [KadeDev](https://github.com/KadeDev)
- [Rozebud](https://github.com/ThatRozebudDude)

## Show Up

(ADD SHITTY STUFF THAN SHOW'S UP MORE STUFF DUMM ASS) 

## Features
- Easy to make Dialogues:
	- You need to add your characters in the `Portrait.hx` script, in `!help` you will have some guides
- Options Menu:
	- It's like any other options menu, the only epik shit is the Optimization stuff, you need to have it in mind when your making your mod ok?
- New Charting State:
	- This one is ez to use and have more stuff, soon it will have mid song events like Psych Engine and more stuff than you can tell me than i add :D:
		- Select GF vercion.
		- Change BG.
		- New Custom Notes.
		- New Charting Tab:
			- Play a sound while the shiti chart line touch a note.
			- Mute Inst/Voices in ChartEditor.
			- Start Full Combo Simulation.

## Build instructions

THESE INSTRUCTIONS ARE FOR COMPILING THE GAME'S SOURCE CODE!!!

IF YOU WANT TO JUST DOWNLOAD AND INSTALL AND PLAY THE GAME NORMALLY, GO TO ITCH.IO TO DOWNLOAD THE GAME FOR PC, MAC, AND LINUX!!

https://ninja-muffin24.itch.io/funkin

IF YOU WANT TO COMPILE THE GAME YOURSELF, CONTINUE READING!!!

### Installing the Required Programs

First, you need to install Haxe and HaxeFlixel. I'm too lazy to write and keep updated with that setup (which is pretty simple). 
1. [Install Haxe 4.1.5](https://haxe.org/download/version/4.1.5/) (Download 4.1.5 instead of 4.2.0 because 4.2.0 is broken and is not working with gits properly...)

You'll also need to install a couple things that involve Gits. To do this, you need to do a few things first.
1. Download [git-scm](https://git-scm.com/downloads). Works for Windows, Mac, and Linux, just select your build.
2. Follow instructions to install the application properly.

Now just go to `!help` and run `HAXE_STUFF.bat` and you will be ready to go

You should have everything ready for compiling the game! Follow the guide below to continue!

and you should be good to go there.

### Compiling game
NOTE: If you see any messages relating to deprecated packages, ignore them. They're just warnings that don't affect compiling

Once you have all those installed, it's pretty easy to compile the game. You just need to run `lime test html5 -debug` in the root of the project to build and run the HTML5 version. (command prompt navigation guide can be found [here](https://ninjamuffin99.newgrounds.com/news/post/1090480))
To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run `lime test linux -debug` and then run the executable file in export/release/linux/bin. For Windows, you need to install [Visual Studio Community 2019](https://visualstudio.microsoft.com/es/thank-you-downloading-visual-studio/?sku=community&rel=16&utm_medium=microsoft&utm_source=docs.microsoft.com&utm_campaign=download+from+relnotes&utm_content=vs2019ga+button). While installing VSC, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)

Once that is done you can open up a command line in the project's directory and run `lime test windows -debug`. Once that command finishes (it takes forever even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin
As for Mac, 'lime test mac -debug' should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.

### Additional guides

- [Command line basics](https://ninjamuffin99.newgrounds.com/news/post/1090480)
