package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import lime.utils.Assets;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;

using StringTools;

class PreloadState extends MusicBeatState
{
    var splash:FlxSprite;
    var loadingText:FlxText;

    var songsCached:Bool = false;
    var songs:Array<String> =["Tutorial", 
    "Bopeebo", "Fresh", "Dadbattle", 
    "Spookeez", "South", "Monster",
    "Pico", "Philly", "Blammed", 
    "Satin-Panties", "High", "Milf", 
    "Cocoa", "Eggnog", "Winter-Horrorland", 
    "Senpai", "Roses", "Thorns",
    "Dum", "freakyMenu"];

    var charactersCached:Bool = false;
    var characters:Array<String> =[
        "characters/bf_assets","characters/GF_assets","DADDY_DEAREST",
        "characters/bfCar","characters/gfCar","characters/Mom_Assets",
        "characters/bfChristmas","characters/gfChristmas","characters/mom_dad_christmas_assets","characters/momCar",
        "characters/monsterChristmas","characters/Pico_FNF_assetss","characters/dum/skippa",
        "characters/week2/Monster_Assets","characters/week2/spooky_kids_assets",
        "weeb/bfPixel","weeb/gfPixel","weeb/senpai","weeb/spirit"
    ];
    
    var soundsCached:Bool = false;
    var sounds:Array<String> =[
        "intro1","intro2","intro3","introGo",
        "missnote1","missnote2","missnote3",
        "pixelText","ANGRY_TEXT_BOX",
        "cancelMenu","confirmMenu","scrollMenu"
    ];

    var graphicsCached:Bool = false;
    var graphics:Array<String> =[
        "logoBumpin", "titleBG", "gfDanceTitle", "titleEnter",
        "stageback", "stagefront", "stagecurtains",
        "rozeSplash","FNF_main_menu_assets","iconGrid",
        "animatedEvilSchool","senpaiCrazy","senpaiPortrait","dialogueBox-pixel",
        "dialogueBox-senpaiMad","arrows-pixels","arrowEnds",
        "noteSplashes","NOTE_assets","go","ready","set","speech_bubble_talking"
    ];

    var cacheStart:Bool = false;

	override function create()
	{

        FlxG.mouse.visible = false;
        FlxG.sound.muteKeys = null;

		Highscore.load();
		KeyBinds.keyCheck();
		PlayerSettings.init();

        PlayerSettings.player1.controls.loadKeyBinds();

        splash = new FlxSprite(0, 0);
        splash.frames = Paths.getSparrowAtlas('Preloading_Screen_Assets');
        splash.animation.addByPrefix('start', 'Apear', 24, false);
        splash.animation.addByPrefix('idle', 'logo bumpin', 24, false);
        splash.animation.addByPrefix('end', 'end', 24, false);
        add(splash);
        splash.animation.play("start");
        splash.updateHitbox();
        splash.screenCenter();

        loadingText = new FlxText(0, FlxG.height - 90, 0, "", 24);
        loadingText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        loadingText.screenCenter(X);
        add(loadingText);

        new FlxTimer().start(1.1, function(tmr:FlxTimer)
        {
            FlxG.sound.play(Paths.sound("thunder_1"));
        });
        
        super.create();

    }

    override function update(elapsed) 
    {
        var animEnd = (splash.animation.curAnim.name == "end");

        if(splash.animation.curAnim.finished && splash.animation.curAnim.name == "start" && !cacheStart){
            preload();
            cacheStart = true;
            splash.animation.play('idle');
        }

        if(songsCached && charactersCached && graphicsCached && soundsCached && !animEnd){
            splash.animation.play("end");

            new FlxTimer().start(0.3, function(tmr:FlxTimer)
            {
                loadingText.screenCenter(X);
                loadingText.text = "Done!";
                FlxG.sound.play(Paths.sound("confirmMenu"));
            });
        }

        if(splash.animation.curAnim.finished && animEnd)
            FlxG.switchState(new TitleState());
        super.update(elapsed);

    }

    function preload(){
        loadingText.text = "Preloading All!";
        loadingText.screenCenter(X);
        if(!songsCached)
            #if sys sys.thread.Thread.create(() -> {
                preloadMusic();
            });
            #else
            preloadMusic();
            #end

        if(!charactersCached)
            #if sys sys.thread.Thread.create(() -> {
                preloadCharacters();
            });
            #else
            preloadCharacters();
            #end

        if(!graphicsCached)
            #if sys sys.thread.Thread.create(() -> {
                preloadGraphics();
            });
            #else
            preloadGraphics();
            #end

        if(!soundsCached)
            #if sys sys.thread.Thread.create(() -> {
                preloadSounds();
            });
            #else
            preloadSounds();
            #end
    }

    function preloadMusic(){
        for(i in 0... sounds.length){
            if(Assets.exists(Paths.music(songs[i] + "_Inst")))
                FlxG.sound.cache(Paths.music(songs[i] + "_Inst"));
            else
                FlxG.sound.cache(Paths.music(songs[i]));
            loadingText.text = "Cached Songs: " + i + "/" + Lambda.count(songs);
        }
        songsCached = true;
    }

    function preloadSounds(){
        for(i in 0... sounds.length){
            FlxG.sound.cache(Paths.sound(sounds[i]));
            loadingText.text = "Cached Sounds: " + i + "/" + Lambda.count(sounds);
        }
        soundsCached = true;
    }

    function preloadCharacters(){
        for(i in 0... characters.length){
            FlxG.sound.cache(Paths.image(characters[i]));
            loadingText.text = "Cached Characters: " + i + "/" + Lambda.count(characters);
        }
        charactersCached = true;
    }

    function preloadGraphics(){
        for(i in 0... graphics.length){
            FlxG.sound.cache(Paths.image(graphics[i]));
            loadingText.text = "Cached Graphic: " + i + "/" + Lambda.count(graphics);
        }
        graphicsCached = true;
    }
}