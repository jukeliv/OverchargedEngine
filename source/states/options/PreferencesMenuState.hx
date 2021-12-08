package states.options;

import flixel.text.FlxText;
import openfl.Lib;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;

class PreferencesMenuState extends MusicBeatState {
    var textMenuOptions:Array<String> = ['Controls','Ghost Tapping','Framerate','Scroll Speed','Antialiasing', 'Toggle FPS Cap','Reset'];
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

    var bf:Character = new Character(0,0);

	var descText:FlxText;

	override function create()
	{
        super.create();

        var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		descText = new FlxText(320, 635, 640, "", 20);
		descText.scrollFactor.set(0, 0);
		descText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.borderQuality = 1;

		Options.load();//new load stuff

		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		for (i in 0...textMenuOptions.length)
		{
            var controlLabel:Alphabet = new Alphabet(0, (60 * i) + 60, textMenuOptions[i].toLowerCase(), true, false);
			controlLabel.setGraphicSize(Std.int(controlLabel.width * 0.8));
			controlLabel.updateHitbox();

			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			controlLabel.ID = i;
			if(controlLabel.ID == 0){
				controlLabel.color = FlxColor.YELLOW;
				controlLabel.alpha = 1;
			}
			else{
				controlLabel.color = FlxColor.WHITE;
				controlLabel.alpha = 0.6;
			}
			grpOptionsTexts.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

        bf.screenCenter();
        bf.x += 350;
        bf.animation.play('idle',true);
        bf.visible = false;
        add(bf);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        bf.antialiasing = Options.antialiasing;

		if (controls.UP_P)
			changeSelection(-1);

		if (controls.DOWN_P)
			changeSelection(1);

		if(controls.LEFT_P){
			switch(textMenuOptions[curSelected]){
				case 'Scroll Speed':
					updateDescription('Scroll Speed: ' + Options.scrollSpeed);
					Options.scrollSpeed-=0.1;
				case 'Framerate':
					updateDescription('Framerate: ' + Options.framerate);
					if(Options.framerate >= 1){
						Options.framerate-=1;
						(cast(Lib.current.getChildAt(0),Main)).setFramerate(Options.framerate);
					}
			}
		}
		if(controls.RIGHT_P){
			switch(textMenuOptions[curSelected]){
				case 'Scroll Speed':
					Options.scrollSpeed+=0.1;
					updateDescription('Scroll Speed: ' + Options.scrollSpeed);
				case 'Framerate':
					if(Options.framerate <= FlxG.save.data.fpsLimit){
						Options.framerate+=1;
						(cast(Lib.current.getChildAt(0),Main)).setFramerate(Options.framerate);
						updateDescription('Framerate: ' + Options.framerate);
					}
			}
		}
        if(controls.ACCEPT){
            switch(textMenuOptions[curSelected]){
				case 'Controls':
					FlxG.state.openSubState(new KeyBindMenu());
                case 'Antialiasing':
					updateDescription('Antialiasing: ' + Options.antialiasing);
					FlxG.sound.play(Paths.sound('confirmMenu'));
                    Options.antialiasing = !Options.antialiasing;
                case 'Toggle FPS Cap':
					updateDescription('Toggle FPS Cap: ' + Options.fpsCap);
					FlxG.sound.play(Paths.sound('confirmMenu'));
                    Options.fpsCap = !Options.fpsCap;
                    (cast(Lib.current.getChildAt(0),Main)).toggleFpsCounter(Options.fpsCap);
				case 'Ghost Tapping':
					updateDescription('Ghost Tapping: ' + Options.ghostTap);
					FlxG.sound.play(Paths.sound('confirmMenu'));
                    Options.ghostTap = !Options.ghostTap;
            }
        }		

		if(controls.BACK){
			trace('Back to the main menu');
			FlxG.switchState(new OptionsMenu());
			Options.save();
		}
    }

	public function updateDescription(str:String){
		for(item in grpOptionsTexts){
			if(item.ID == curSelected)
				item.text = str;
		}
	}

	public function changeSelection(huh:Int){
		curSelected += huh;

		FlxG.sound.play(Paths.sound('scrollMenu'),1);

		if (curSelected < 0)
			curSelected = textMenuOptions.length - 1;

		if (curSelected >= textMenuOptions.length)
			curSelected = 0;

        if(textMenuOptions[curSelected] == 'Antialiasing')
            bf.visible = true;
        else
            bf.visible = false;

		var bullShit:Int = 0;

		for (item in grpOptionsTexts.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;
		
			item.alpha = 0.6;
			item.color = FlxColor.WHITE;

			if (item.targetY == 0)
			{
				item.color = FlxColor.YELLOW;
				item.alpha = 1;
			}
		}
	}
}