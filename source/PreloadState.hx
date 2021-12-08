package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;

using StringTools;

class PreloadState extends MusicBeatState
{
    var splash:FlxSprite;
    var loadingText:FlxText;

    var songsCached:Bool = false;
    var songs:Array<String> =[
        "Tutorial","freakyMenu"
    ];

    var charactersCached:Bool = false;
    var characters:Array<String> =[
        "characters/bf_assets",
        "characters/GF_assets",
        "characters/DADDY_DEAREST",
        "characters/dum/skippa"];
    
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
        "rozeSplash","FNF_main_menu_assets","iconGrid"];

    var cacheStart:Bool = false;

	override function create()
	{

        FlxG.mouse.visible = false;
        FlxG.sound.muteKeys = null;

        splash = new FlxSprite(0, 0);
        splash.frames = Paths.getSparrowAtlas('rozeSplash');
        splash.animation.addByPrefix('start', 'Splash Start', 24, false);
        splash.animation.addByPrefix('end', 'Splash End', 24, false);
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
            sys.thread.Thread.create(() -> {
                preloadMusic();
            });

        if(!charactersCached)
            sys.thread.Thread.create(() -> {
                preloadCharacters();
            });

        if(!graphicsCached)
            sys.thread.Thread.create(() -> {
                preloadGraphics();
            });

        if(!soundsCached)
            sys.thread.Thread.create(() -> {
                preloadSounds();
            });
    }

    function preloadMusic(){
        for(i in 0... sounds.length){
            FlxG.sound.cache(Paths.sound(songs[i] + "_Inst"));
            loadingText.text = "Cached Songs: " + i + "/" + songs.length;
        }
        songsCached = true;
    }

    function preloadSounds(){
        for(i in 0... sounds.length){
            FlxG.sound.cache(Paths.sound(sounds[i]));
            loadingText.text = "Cached Sounds: " + i + "/" + sounds.length;
        }
        soundsCached = true;
    }

    function preloadCharacters(){
        for(i in 0... characters.length){
            FlxG.sound.cache(Paths.image(characters[i]));
            loadingText.text = "Cached Characters: " + i + "/" + characters.length;
        }
        charactersCached = true;
    }

    function preloadGraphics(){
        for(i in 0... graphics.length){
            FlxG.sound.cache(Paths.image(graphics[i]));
            loadingText.text = "Cached Graphic: " + i + "/" + graphics.length;
        }
        graphicsCached = true;
    }
}