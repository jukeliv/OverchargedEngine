package states.options;

import openfl.Lib;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;

class PreferencesMenuState extends MusicBeatState {
    var textMenuItems:Array<String> = ['Scroll Speed','Ghost Tapping','Framerate','Antialiasing', 'Toggle FPS Cap'];
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

    var bf:Character = new Character(0,0);

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

		Options.load();//new load stuff

		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		for (i in 0...textMenuItems.length)
		{
            var controlLabel:Alphabet = new Alphabet(0, (60 * i) + 60, textMenuItems[i].toLowerCase(), true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			if(i == 0){
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
        bf.flipX = true;
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
			switch(textMenuItems[curSelected]){
				case 'Scroll Speed':
					Options.scrollSpeed-=0.1;
				case 'Framerate':
					if(Options.framerate >= 1){
						Options.framerate-=1;
						(cast(Lib.current.getChildAt(0),Main)).setFramerate(Options.framerate);
					}
			}
		}
		if(controls.RIGHT_P){
			switch(textMenuItems[curSelected]){
				case 'Scroll Speed':
					Options.scrollSpeed+=0.1;
				case 'Framerate':
					if(Options.framerate <= FlxG.save.data.fpsLimit){
						Options.framerate+=1;
						(cast(Lib.current.getChildAt(0),Main)).setFramerate(Options.framerate);
					}
			}
		}
        if(controls.ACCEPT){
            switch(textMenuItems[curSelected]){
                case 'Antialiasing':
					FlxG.sound.play(Paths.sound('confirmMenu'));
                    Options.antialiasing = !Options.antialiasing;
                case 'Toggle FPS Cap':
					FlxG.sound.play(Paths.sound('confirmMenu'));
                    Options.fpsCap = !Options.fpsCap;
                    (cast(Lib.current.getChildAt(0),Main)).toggleFpsCounter(Options.fpsCap);
				case 'Ghost Tapping':
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

	public function changeSelection(huh:Int){
		curSelected += huh;

		FlxG.sound.play(Paths.sound('scrollMenu'),1);

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

        if(textMenuItems[curSelected] == 'Antialiasing')
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